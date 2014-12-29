import numpy as np
import cv2
import requests
from matplotlib import pyplot as plt
import os
from scp_gui import UI
import string
from scp_parser import SCP_Parser 

green_color = (0,255,255)
red_color = (0,255,0)
blue_color = (255,0,0)

aspect_ratio = 1.8
rough_range_width = 60000
rough_range_height = 6000


def process_plate(data,ip):
    image = cv2.imdecode(data, 1)
    preprocessed_image = cv2.imdecode(data, 1)
    cv2.imwrite('original_image_path.jpg',image)

    gray_scale = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    cv2.imwrite('gri_image_path.jpg',gray_scale)

    gaussian_blur = cv2.GaussianBlur(gray_scale,(5,5),0)
    cv2.imwrite('difum_image_path.jpg',gaussian_blur)

    gradient = cv2.Sobel(gaussian_blur, cv2.CV_8U, 1, 0, ksize=3)
    cv2.imwrite('grad_image_path.jpg',gradient)

    _,umbral = cv2.threshold(gradient, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    cv2.imwrite('thres_image_path.jpg',umbral)

    structuring_element = cv2.getStructuringElement(cv2.MORPH_RECT,(23,4))
    morfo = cv2.morphologyEx(umbral, cv2.MORPH_CLOSE, structuring_element)
    cv2.imwrite('mor_image_path.jpg',morfo)

    contours,_ = cv2.findContours(morfo, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    draw_contours(image, contours)
    cv2.imwrite('candi_image_path.jpg',image)

    try:
        verify_plate(preprocessed_image, image, contours)
    except:
        print "Not plate found"
        not_image_found(parsed_plate)
        return False

    cv2.imwrite('verified_image_path.jpg',image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    tess = os.popen('tesseract bien_image_path.jpg output',"r").read()
    cat = os.popen('cat output.txt',"r").read()
    print cat
    print ip

    plate = cat.strip();
    parsed_plate = SCP_Parser(plate).parse_plate()

    print "request = Placa: " + parsed_plate + " Ip : " + str(ip)
    request = requests.get("http://scpweb.herokuapp.com/api/authorize_plate?plate="+parsed_plate+"&cam="+str(ip))
    response = request.json()
    print response
    
    tess = None 
    cat = None
    if parsed_plate.strip() == "IMA6EN":
        parsed_plate = "No encontrada"

    ui = UI("original_image_path.jpg", "gri_image_path.jpg", 
        "difum_image_path.jpg", "grad_image_path.jpg", 
        "thres_image_path.jpg", "mor_image_path.jpg", 
        "candi_image_path.jpg", "verified_image_path.jpg", 
        "verified_plate_image_path.jpg", "bien_image_path.jpg", 
        ip, parsed_plate, response)

    not_image_found()
    
    return (response['message'] == "Vehicle Found")

def not_image_found():
    not_found = cv2.imread("not_found.jpg",1)
    cv2.imwrite('original_image_path.jpg',not_found)
    cv2.imwrite('gri_image_path.jpg',not_found)
    cv2.imwrite('difum_image_path.jpg',not_found)
    cv2.imwrite('grad_image_path.jpg',not_found)
    cv2.imwrite('thres_image_path.jpg',not_found)
    cv2.imwrite('mor_image_path.jpg',not_found)
    cv2.imwrite('candi_image_path.jpg',not_found)
    cv2.imwrite('verified_image_path.jpg',not_found)
    cv2.imwrite("verified_plate_image_path.jpg",not_found)
    cv2.imwrite("bien_image_path.jpg",not_found)
    
def draw_contours(image, contours):
    for cnt in contours:
        rectangle = cv2.minAreaRect(cnt)
        points = cv2.cv.BoxPoints(rectangle)
        points = np.int0(points)  
        cv2.drawContours(image, [points], 0, green_color, 2)

def verified_contour(contour):
    rectangle = cv2.minAreaRect(contour)
    box = cv2.cv.BoxPoints(rectangle)
    box = np.int0(box)  
    output = False
    width = (rectangle[1][0])
    height = (rectangle[1][1])

    if ((width != 0) & (height != 0)  and ( ((width >= 130) and (width <= 170)) and ((height >= 50) and (height <= 85)))):
        if (((height / width > aspect_ratio) & (height > width)) | ((width / height> aspect_ratio) & (width > height))):
            if((height * width < rough_range_width) & (height * width > rough_range_height)):
                print width
                print height
                print ""
                output=True
    return output

def save_verified_plate(plate_image, width, height):
    cv2.imwrite("verified_plate_image_path.jpg",plate_image)	

def verified_plate_bg_white(plate_image):
    plate_image[np.where((plate_image==[0,0,255]).all(axis=2))] = [255,255,255]

def is_perfect_rectangle(width,height):
    div = round(width/height,1)
    return (div == 2 or div == (2.1) or (div-1) == (2.1) )

def change_bg_plate(plate_image):
    n = 2    # Number of levels of quantization
    indices = np.arange(0,256)   # List of all colors 
    divider = np.linspace(0,255,n+1)[1] # we get a divider
    quantiz = np.int0(np.linspace(0,255,n)) # we get quantization colors
    color_levels = np.clip(np.int0(indices/divider),0,n-1) # color levels 0,1,2..
    palette = quantiz[color_levels] # Creating the palette
    im2 = palette[plate_image]  # Applying palette on image
    im2 = cv2.convertScaleAbs(im2) # Converting image back to uint8
    #RGB
    im2[np.where((im2 == [0,0,255]).all(axis = 2))] = [255,255,255]#Blue
    im2[np.where((im2 == [0,255,0]).all(axis = 2))] = [255,255,255]#Green
    im2[np.where((im2 == [255,0,0]).all(axis = 2))] = [255,255,255]#Red
    im2[np.where((im2 == [0,255,255]).all(axis = 2))] = [255,255,255]#Light Blue
    im2[np.where((im2 == [255,255,0]).all(axis = 2))] = [255,255,255]#Yellow
    im2[np.where((im2 == [255,0,255]).all(axis = 2))] = [255,255,255]#Yellow
    cv2.imwrite("bien_image_path.jpg",im2)  



def verify_plate(image, image_processed, contours):
    for contour in contours:
        if verified_contour(contour):
            rectangle = cv2.minAreaRect(contour)
            box = cv2.cv.BoxPoints(rectangle)
            box = np.int0(box)
            x           =   int(rectangle[0][0])
            y           =   int(rectangle[0][1])+8
            width       =   int(rectangle[1][0])
            height      =   int(rectangle[1][1])
            centre      =   (x,y)
            cv2.drawContours(image_processed, [box], 0, red_color,2)
            cro = image[(y-((height/4))-2):y+((height/4)+4), (x-((width/2))+6):x+((width/2)-3)]
            if (is_perfect_rectangle(width,height)):
                save_verified_plate(cro, width, height)
                change_bg_plate(cro)            

def show_with_plt(img):
    plt.imshow(img)
    plt.xticks([]), plt.yticks([])  # to hide tick values on X and Y axis
    plt.show()

def show_img(title, img):
    cv2.imshow(title,img)
