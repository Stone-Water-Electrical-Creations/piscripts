#!/usr/bin/env python

import shutil
import tempfile
import os.path as pt
import sys
import libtorrent as lt
from time import sleep
from argparse import ArgumentParser


def magtor(magnet, torrent_name=None):
    if torrent_name and \
            not pt.isdir(torrent_name) and \
            not pt.isdir(pt.dirname(pt.abspath(torrent_name))):
        print("Invalid torrent folder: " + pt.dirname(pt.abspath(torrent_name)))
        print("")
        sys.exit(0)

    tempdir = tempfile.mkdtemp()
    ses = lt.session()
    params = {
        'save_path': tempdir,
        'storage_mode': lt.storage_mode_t(2),
        'paused': False,
        'auto_managed': True,
        'duplicate_is_error': True
    }
    handle = lt.add_magnet_uri(ses, magnet, params)

    print("Downloading Metadata (this may take a while)")
    while (not handle.has_metadata()):
        try:
            sleep(1)
        except KeyboardInterrupt:
            print("Aborting...")
            ses.pause()
            print("Cleanup dir " + tempdir)
            shutil.rmtree(tempdir)
            sys.exit(0)
    ses.pause()
    print("Done")

    torinfo = handle.get_torrent_info()
    torfile = lt.create_torrent(torinfo)

    torrent = pt.abspath(torinfo.name() + ".torrent")

    if torrent_name:
        if pt.isdir(torrent_name):
            torrent = pt.abspath(pt.join(
                torrent_name, torinfo.name() + ".torrent"))
        elif pt.isdir(pt.dirname(pt.abspath(torrent_name))):
            torrent = pt.abspath(torrent_name)

    print("Saving torrent file here : " + torrent + " ...")
    torcontent = lt.bencode(torfile.generate())
    f = open(torrent, "wb")
    f.write(lt.bencode(torfile.generate()))
    f.close()
    print("Saved! Cleaning up dir: " + tempdir)
    ses.remove_torrent(handle)
    shutil.rmtree(tempdir)

    return torrent

def main():
    parser = ArgumentParser(description="A command line tool that converts magnet links in to .torrent files")
    parser.add_argument('-m','--magnet', help='The magnet url')
    parser.add_argument('-t','--torrent', help='The torrent file name')

    conditionally_required_arg_parser = ArgumentParser(description="A command line tool that converts magnet links in to .torrent files")
    conditionally_required_arg_parser.add_argument('-m','--magnet', help='The magnet url')
    conditionally_required_arg_parser.add_argument('-t','--torrent', help='The torrent file name', required=True)

    magnet = None
    torrent_name = None

    #
    # Attempting to retrieve args using the new method
    #
    args = vars(parser.parse_known_args()[0])
    if args['magnet'] is not None:
        magnet = args['magnet']
        argsHack = vars(conditionally_required_arg_parser.parse_known_args()[0])
        torrent_name = argsHack['torrent']
    if args['torrent'] is not None and torrent_name is None:
        torrent_name = args['torrent']
        if magnet is None:
            #
            # This is a special case.
            # This is when the user provides only the "torrent" args.
            # We're forcing him to provide the 'magnet' args in the new method
            #
            print ('usage: {0} [-h] [-m MAGNET] -t TORRENT'.format(sys.argv[0]))
            print ('{0}: error: argument -m/--magnet is required'.format(sys.argv[0]))
            sys.exit()
    #
    # Defaulting to the old of doing things
    # 
    if torrent_name is None and magnet is None:
        if len(sys.argv) >= 2:
            magnet = sys.argv[1]
        if len(sys.argv) >= 3:
            torrent_name = sys.argv[2]

    magtor(magnet, torrent_name)


if __name__ == "__main__":
    main()
