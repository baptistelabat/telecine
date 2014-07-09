from SimpleCV import Camera, Display, Image
import serial
import time

disp = Display((640, 480))
cam = Camera(1)
counter = 0


locations = ['/dev/ttyACM0','/dev/ttyACM1','/dev/ttyACM2','/dev/ttyACM3','/dev/ttyACM4','/dev/ttyACM5','/dev/ttyUSB0','/dev/ttyUSB1','/dev/ttyUSB2','/dev/ttyUSB3','/dev/ttyS0','/dev/ttyS1','/dev/ttyS2','/dev/ttyS3']
for device in locations:
    print device
    try:
        print "Trying...", device
        ser = serial.Serial(device, baudrate=19200, timeout=1)
        print "Connected on ", device
        break
    except:
        print "Failed to connect on ", device
time.sleep(1.5)

while disp.isNotDone():
    img = cam.getImage()
    if ser.inWaiting() > 0:
      line = ser.readline()
      print "Received from arduino: ", line
      print line[0]
    if line[0]=="1":
      img.save(str(counter) + ".png")
      counter = counter +1
