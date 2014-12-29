import RPi.GPIO as GPIO
from time import sleep

try:
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(12,GPIO.OUT)
    GPIO.setwarnings(False)

    contador = 0

    while contador < 7:
        GPIO.output(12,True)
        sleep(0.3)
        GPIO.output(12,False)
        sleep(0.3)
        contador = contador + 1

except KeyboardInterrupt:
    GPIO.cleanup()
