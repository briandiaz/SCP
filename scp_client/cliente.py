import socket
import cv2
import numpy
import os
import sys
import RPi.GPIO as GPIO
from time import sleep

TCP_IP = '192.168.0.37'
TCP_PORT = 5004
RECV_BUFFER = 4096

os.popen('./camcv -t 500 -w 1024 -h 768')

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
