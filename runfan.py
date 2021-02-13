#!/usr/bin/env python3
# Author: Put any name here :P
import os
from time import sleep
import RPi.GPIO as GPIO
pin1 = 18 # The pin ID, edit here to change it
pin2 = 14 # The pin ID, edit here to change it
pinoff=0
maxTMP = 50 # The maximum temperature in Celsius after which we trigger the fan on low
def setup():
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pin1, GPIO.OUT)
    GPIO.setup(pin2, GPIO.OUT)
    return()
def getCPUtemperature():
    res = os.popen('vcgencmd measure_temp').readline()
    temp =(res.replace("temp=","").replace("'C\n",""))
    print("temp is {0}".format(temp)) #Uncomment here for testing
    return temp
def fanON():
    setPin(1)
    return()
def fanOFF():
    setPin(0)
    return()
def getTEMP():
    CPU_temp = float(getCPUtemperature())
    if CPU_temp>maxTMP:
        fanON()
    else:
        fanOFF()
    return()
def setPin(mode): # A little redundant function but useful if you want to add loggin
    GPIO.output(pin1, mode)
    GPIO.output(pin2, mode)
    return()
try:
    setup()
    while True:
        getTEMP()
        sleep(3)
        if GPIO.input(pin2) is pinoff :
            break     
except KeyboardInterrupt: # trap a CTRL+C keyboard interrupt 
    GPIO.cleanup() # resets all GPIO ports used by this program
