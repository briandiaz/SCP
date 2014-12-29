import socket
import cv2
import numpy
import os

TCP_IP = 'localhost'
TCP_PORT = 5001
RECV_BUFFER = 4096


sock = socket.socket()
sock.connect((TCP_IP, TCP_PORT))
print "Connected with server"
img = cv2.imread("pa.jpg",1)
print(str(len(img)).ljust(16))

data = cv2.imencode('.jpg', img)[1]
stringData = data.tostring()

sock.send( str(len(stringData)).ljust(16));
sock.send( stringData );
print "Image send!"
data = sock.recv(RECV_BUFFER)
print data

sock.close()