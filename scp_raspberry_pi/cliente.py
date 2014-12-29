import socket
import cv2
import numpy
import os
import sys
import RPi.GPIO as GPIO
from time import sleep
import time

def measure():

  GPIO.output(GPIO_TRIGGER, True)
  time.sleep(0.00001)
  GPIO.output(GPIO_TRIGGER, False)
  start = time.time()
  
  while GPIO.input(GPIO_ECHO)==0:
    start = time.time()

  while GPIO.input(GPIO_ECHO)==1:
    stop = time.time()

  elapsed = stop-start
  distance = (elapsed * 34300)/2

  return distance

def measure_average():

  distance1=measure()
  time.sleep(0.1)
  distance2=measure()
  time.sleep(0.1)
  distance3=measure()
  distance = distance1 + distance2 + distance3
  distance = distance / 3
  return distance

GPIO.setmode(GPIO.BCM)

GPIO_TRIGGER = 23
GPIO_ECHO    = 24

# Set pins as output and input
GPIO.setup(GPIO_TRIGGER,GPIO.OUT)  # Trigger
GPIO.setup(GPIO_ECHO,GPIO.IN)      # Echo

# Set trigger to False (Low)
GPIO.output(GPIO_TRIGGER, False)

TCP_IP = '192.168.0.3'
TCP_PORT = 5001
RECV_BUFFER = 4096

range_floor = 2.0
range_ceiling = 2.5

try:

  while True:

    distance = measure_average()
    print "Distance : %.1f" % distance
    time.sleep(1)

    if distance >= range_floor and distance <= range_ceiling:
    	os.popen('./camcv -t 500 -w 1024 -h 768 -roi 0.5,0.5,0.30,0.30 -n')
    	sock = socket.socket()
    	sock.connect((TCP_IP, TCP_PORT))
		print "Connected with server"
		img = cv2.imread("foobar.jpg",1)
		print(str(len(img)).ljust(16))

		data = cv2.imencode('.jpg', img)[1]
		stringData = data.tostring()

		sock.send( str(len(stringData)).ljust(16));
		sock.send( stringData );
		print "Image send!"
		data = sock.recv(RECV_BUFFER)
		print data

		if data == 'True':
		    os.popen('sudo python granted.py')
		else:
		    os.popen('sudo python denied.py')

		sock.close()


except KeyboardInterrupt:
  # User pressed CTRL-C
  # Reset GPIO settings
  GPIO.cleanup()






