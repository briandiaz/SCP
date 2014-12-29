import socket
import cv2
import numpy
import requests
import scp_processing

TCP_PORT = 5005

def receive_data(sock, count):
    buffer = b''
    while count:
        newbuffer = sock.recv(count)
        if not newbuffer: return None
        buffer += newbuffer
        count -= len(newbuffer)
    return buffer


TCP_IP = ''

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((TCP_IP, TCP_PORT))
s.listen(True)
print "Server is Up"

while 1:
    conn, addr = s.accept()
    print 'Connected with ' + addr[0] + ':' + str(addr[1])
    length = receive_data(conn, 16)
    stringData = receive_data(conn, int(length))
    if not stringData: break
    data = numpy.fromstring(stringData, dtype='uint8')

    plate = scp_processing.process_plate(data,addr[0])
    print plate
    #s.sendall(str(plate))
    conn.sendall(str(plate))
    #s.send(plate)

s.close()
