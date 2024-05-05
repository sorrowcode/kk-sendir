from bluetooth import *
import socket

server = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_STREAM, socket.BTPROTO_RFCOMM)
server.bind(("00:10:60:d0:f2:b8", 4))
server.listen(1)

ndserver = socket.socket(so )

client, addr = server.accept()

try:
    while True:
        data = client.recv(1024)
        if not data:
            break
        print(f"Message: {data.decode('utf8')}")
        message = input("Enter message")
        client.send(message.encode('utf8'))
        
except OSError as e:
    pass

client.close()
server.close()