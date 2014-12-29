from Tkinter import *
from ttk import *
import json
from Tkinter import Tk, Text, BOTH, W, N, E, S


from PIL import Image, ImageTk


class UI:
    """docstring for UI"""
    def __init__(self,
        original_image_path,
        gri_image_path,
        difum_image_path,
        grad_image_path,
        thres_image_path,
        mor_image_path,
        candi_image_path,
        verified_image_path,
        verified_plate_image_path,
        bien_image_path,
        ip,
        plate,
        data):
        self.ip = ip
        self.root = Tk()

        self.frame = Frame(self.root)

        original_file = Image.open(original_image_path).resize((800, 500),Image.ANTIALIAS)
        self.original_image = ImageTk.PhotoImage(original_file)

        gri_file = Image.open(gri_image_path).resize((800, 500),Image.ANTIALIAS)
        self.gri_image = ImageTk.PhotoImage(gri_file)

        difum_file = Image.open(difum_image_path).resize((800, 500),Image.ANTIALIAS)
        self.difum_image = ImageTk.PhotoImage(difum_file)

        grad_file = Image.open(grad_image_path).resize((800, 500),Image.ANTIALIAS)
        self.grad_image = ImageTk.PhotoImage(grad_file)

        thres_file = Image.open(thres_image_path).resize((800, 500),Image.ANTIALIAS)
        self.thres_image = ImageTk.PhotoImage(thres_file)

        mor_file = Image.open(mor_image_path).resize((800, 500),Image.ANTIALIAS)
        self.mor_image = ImageTk.PhotoImage(mor_file)

        candi_file = Image.open(candi_image_path).resize((800, 500),Image.ANTIALIAS)
        self.candi_image = ImageTk.PhotoImage(candi_file)

        verified_img = Image.open(verified_image_path).resize((800, 500),Image.ANTIALIAS)
        self.verified_image = ImageTk.PhotoImage(verified_img)

        verified_plate_img = Image.open(verified_plate_image_path)
        self.verified_plate_image = ImageTk.PhotoImage(verified_plate_img)

        bien_file = Image.open(bien_image_path)
        self.bien_image = ImageTk.PhotoImage(bien_file)

        self.plate = plate
        if data:
            self.data = data
            if not(self.data["message"] == "Vehicle Found"):
                self.data = None
                self.is_vehicle_data = False
            else:
                self.is_vehicle_data = True
        else:
            self.data = None
            self.is_vehicle_data = True


        self.w = self.root.winfo_screenwidth()
        self.h = self.root.winfo_screenheight()

        self.create_frame()

        self.root.title("SCP MiddleWare GUI")
        self.root.geometry("%dx%d+0+0" % (980, self.h-100))
        self.root.mainloop()


    def create_frame(self):

        frame1 = Frame(self.root,width=500, height=500)
        frame2 = Frame(self.root,width=800, height=200)
        frame1.pack()
        frame2.pack( fill=BOTH, expand=1)
        frame1.place(x=0,y=0)
        frame2.place(x=0,y=560)

        note = Notebook(frame1)
        frame1.style = Style()
        frame1.style.theme_use("clam")
        frame2.style = Style()
        frame2.style.theme_use("clam")

        tab1 = Frame(note)
        tab2 = Frame(note)
        tab3 = Frame(note)
        tab4 = Frame(note)
        tab5 = Frame(note)
        tab6 = Frame(note)
        tab7 = Frame(note)
        tab8 = Frame(note)
        tab9 = Frame(note)
        tab10 = Frame(note)
        tab11 = Frame(note)


        Button(tab1, text='Exit').pack(padx=self.w-120, pady=self.h-100)
        note.add(tab1, text = "Imagen Recibida",compound=TOP)
        note.add(tab2, text = "Escala Grices")
        note.add(tab3, text = "Difuminado")
        note.add(tab4, text = "Gradiente")
        note.add(tab5, text = "Threshold")
        note.add(tab6, text = "Morfologica")
        note.add(tab7, text = "Candidatas")
        note.add(tab8, text = "Aceptada")
        note.add(tab9, text = "Recorte")
        note.add(tab10,text = "Floodfill")


        label_original_image = Label(tab1, image=self.original_image)
        label_original_image.place(x=5, y=20)
        label_original_image = Label(frame2,foreground="black",text="Cam: "+self.ip + "     Placa: "+str(self.plate),
            font=("Times", 16), width=80)
        label_original_image.pack()


        label_gri_image = Label(tab2, image=self.gri_image)
        label_gri_image.place(x=5, y=20)
        label_gri_image = Label(frame2, width=20)
        label_gri_image.pack()

        label_difum_image = Label(tab3, image=self.difum_image)
        label_difum_image.place(x=5, y=20)
        label_difum_image = Label(frame2, width=20)
        label_difum_image.pack()

        label_grad_image = Label(tab4, image=self.grad_image)
        label_grad_image.place(x=5, y=20)
        label_grad_image = Label(frame2, width=20)
        label_grad_image.pack()

        label_thres_image = Label(tab5, image=self.thres_image)
        label_thres_image.place(x=5, y=20)
        label_thres_image = Label(frame2, width=20)
        label_thres_image.pack()

        label_mor_image = Label(tab6, image=self.mor_image)
        label_mor_image.place(x=5, y=20)
        label_mor_image = Label(frame2, width=20)
        label_mor_image.pack()

        label_candi_image = Label(tab7, image=self.candi_image)
        label_candi_image.place(x=5, y=20)
        label_candi_image = Label(frame2, width=20)
        label_candi_image.pack()

        label_aceptadas_image = Label(tab8, image=self.verified_image)
        label_aceptadas_image.place(x=5, y=20)
        label_aceptadas_image = Label(frame2, width=20)
        label_aceptadas_image.pack()

        label_recorte_image = Label(tab9, image=self.verified_plate_image)
        label_recorte_image.place(x=5, y=20)
        label_recorte_image = Label(frame2, width=20)
        label_recorte_image.pack()

        label_flod_image = Label(tab10, image=self.bien_image)
        label_flod_image.place(x=5, y=20)
        label_flod_image = Label(frame2, width=20)
        label_flod_image.pack()

        frame3 = Frame(tab11, width=300, height=500)
        frame3.style = Style()
        frame3.style.theme_use("clam")
        frame3.place(x=100, y=10)
        frame3.pack(fill=BOTH, expand=10)

        if self.is_vehicle_data:
            note.add(tab11,text = "Busqueda")
            column_client_name = 1
            column_client_data = 2

            column_vehicle_name = 4
            column_vehicle_data = 5

            column_cam_name = 7
            column_cam_data = 8

            Label(frame3,text='    ',font=("Times", 13, 'bold')).grid(row=0, column=0, sticky=W)

            Label(frame3,text='    ',font=("Times", 13, 'bold')).grid(row=0, column=3, sticky=W)

            Label(frame3,text='    ',font=("Times", 13, 'bold')).grid(row=0, column=6, sticky=W)


            Label(frame3,font=("Times", 13, 'bold')).grid(row=0, column=column_client_name, sticky=W)
            Label(frame3, text="Cliente", font=("Times", 13, 'bold')).grid(row=1, column=column_client_name, sticky=W)
            Label(frame3, font=("Times", 13, 'bold')).grid(row=2, column=column_client_name, sticky=W)
            Label(frame3, text="Nombre:", font=("Times", 13, 'bold')).grid(row=3, column=column_client_name, sticky=W)
            Label(frame3, text="Apellido:", font=("Times", 13, 'bold')).grid(row=4, column=column_client_name, sticky=W)
            Label(frame3, text="Sexo:", font=("Times", 13, 'bold')).grid(row=5, column=column_client_name, sticky=W)
            Label(frame3, text="Cedula:", font=("Times", 13, 'bold')).grid(row=6, column=column_client_name, sticky=W)
            Label(frame3, text="Telefono:", font=("Times", 13, 'bold')).grid(row=7, column=column_client_name, sticky=W)
            Label(frame3, text="Movil:", font=("Times", 13, 'bold')).grid(row=8, column=column_client_name, sticky=W)
            Label(frame3, text="Correo:", font=("Times", 13, 'bold')).grid(row=9, column=column_client_name, sticky=W)

            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["first_name"], font=("Times", 13)).grid(row=3, column=column_client_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["last_name"], font=("Times", 13)).grid(row=4, column=column_client_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["sex"], font=("Times", 13)).grid(row=5, column=column_client_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["identification_card"], font=("Times", 13)).grid(row=6, column=column_client_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["phone"], font=("Times", 13)).grid(row=7, column=column_client_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["mobile"], font=("Times", 13)).grid(row=8, column=column_client_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["owner"]["person"]["email"], font=("Times", 13)).grid(row=9, column=column_client_data, sticky=W)

            #Vehicle
            Label(frame3, text="Vehiculo", font=("Times", 13, 'bold')).grid(row=1, column=column_vehicle_name, sticky=W)
            Label(frame3, text="Marca:", font=("Times", 13, 'bold')).grid(row=3, column=column_vehicle_name, sticky=W)
            Label(frame3, text="Modelo:", font=("Times", 13, 'bold')).grid(row=4, column=column_vehicle_name, sticky=W)
            Label(frame3, text="Ano:", font=("Times", 13, 'bold')).grid(row=5, column=column_vehicle_name, sticky=W)
            Label(frame3, text="Color:", font=("Times", 13, 'bold')).grid(row=6, column=column_vehicle_name, sticky=W)
            Label(frame3, text="Senales Particulares:", font=("Times", 13, 'bold')).grid(row=7, column=column_vehicle_name, sticky=W)
            Label(frame3, text="Placa:", font=("Times", 13, 'bold')).grid(row=8, column=column_vehicle_name, sticky=W)

            Label(frame3, text=self.data["vehicle"]["brand"]["name"], font=("Times", 13)).grid(row=3, column=column_vehicle_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["model"]["name"], font=("Times", 13)).grid(row=4, column=column_vehicle_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["year"], font=("Times", 13)).grid(row=5, column=column_vehicle_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["color"], font=("Times", 13)).grid(row=6, column=column_vehicle_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["special_signs"], font=("Times", 13)).grid(row=7, column=column_vehicle_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["plate_number"], font=("Times", 13)).grid(row=8, column=column_vehicle_data, sticky=W)

            #Cam

            Label(frame3, text="Camara", font=("Times", 13, 'bold')).grid(row=1, column=column_cam_name, sticky=W)
            Label(frame3, text="Ubicacion:", font=("Times", 13, 'bold')).grid(row=3, column=column_cam_name, sticky=W)
            Label(frame3, text="IP:", font=("Times", 13, 'bold')).grid(row=4, column=column_cam_name, sticky=W)

            Label(frame3, text=self.data["vehicle"]["cam"]["location"], font=("Times", 13)).grid(row=3, column=column_cam_data, sticky=W)
            Label(frame3, text=self.data["vehicle"]["cam"]["ip_addres"], font=("Times", 13)).grid(row=4, column=column_cam_data, sticky=W)

        note.pack()

"""
ui = UI("original_image_path.jpg", "gri_image_path.jpg",
    "difum_image_path.jpg", "grad_image_path.jpg",
    "thres_image_path.jpg", "mor_image_path.jpg",
    "candi_image_path.jpg", "verified_image_path.jpg",
    "verified_plate_image_path.jpg", "bien_image_path.jpg",
    "192.168.0.40", "G250123", '{"vehicle":{"id":18,"brand":{"id":2,"name":"BMW"},"model":{"id":4,"name":"X5"},"year":2015,"color":"Negra","special_signs":"Nueva","plate_number":"G250123","owner":{"client":{"id":8},"person":{"id":14,"first_name":"Jose","last_name":"Reyes","sex":"Male","email":"jose_ismael_42@hotmail.com","phone":"(809) 581-8216","mobile":"(829) 729-6164","identification_card":"031-0517912-5","photo":{"photo":{"url":null,"small":{"url":null},"medium":{"url":null},"large":{"url":null}}}}},"photo":"http://www.vistabmw.com/mm5/graphics/00000001/bmw-x5-xdrive35d.jpg","cam":{"id":2,"location":"Puerta 1 - Entrada","ip_addres":"192.168.0.40","mac_address":"ACasd","created_at":"2014-12-13T02:37:39.441-04:00","updated_at":"2014-12-13T17:11:38.716-04:00"}},"message":"Vehicle Found"}')
ui = UI("original_image_path.jpg", "gri_image_path.jpg",
    "difum_image_path.jpg", "grad_image_path.jpg",
    "thres_image_path.jpg", "mor_image_path.jpg",
    "candi_image_path.jpg", "verified_image_path.jpg",
    "verified_plate_image_path.jpg", "bien_image_path.jpg",
    "192.168.0.40", "G250123", '{"message":"Vehicle Not Found"}')
"""