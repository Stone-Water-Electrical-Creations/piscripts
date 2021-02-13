#!/bin/python3
import RPi.GPIO as GPIO
import subprocess

GPIO.setwarnings (False)
GPIO.setmode (GPIO.BCM)
GPIO.setup (16, GPIO.OUT)
GPIO.setup (12, GPIO.OUT)



exit_code=subprocess.call('ping -c 4 www.google.com'.split())
if  exit_code is 0:
    GPIO.output(16, True)
    GPIO.output(12, False)
else:
    GPIO.output(16, False)
    GPIO.output(12, True)
