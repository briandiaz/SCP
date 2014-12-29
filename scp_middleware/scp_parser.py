import string
punctuations = set(string.punctuation)


initial_char_plate_contingency = {
           8 : "B",
           3 : "B",
           0 : "O",
           1 : "I",
           6: "G",
           5: "G",
           2: "Z"

}
numbers_plate_contingency_1 = {
           "B" : 3,
           "b" : 6,
           "O": 0,
           "o": 0,
           "I": 1,
           "i": 1,
           "G": 6,
           "g": 6,
           "S": 5,
           "s": 5,
           "Z": 2,
           "z": 2,
           "U": 0,
           "u": 0,
           "L": 1,
           "l": 1
}
numbers_plate_contingency_2 = {
        "B" : 8,
}

is_number = [0,1,2,3,4,5,6,7,8]

class SCP_Parser:


    def __init__(self, plate):
        self.plate = plate


    def remove_punctuations(self, plate):
        parsed_plate = ""
        for char in plate:
            if char not in punctuations:
                parsed_plate += char
        return parsed_plate

    def parse_plate_type_char(self, plate):
        plate_type = plate[0]
        if plate_type.isalpha():
            if plate_type in numbers_plate_contingency_1:
                plate_type = numbers_plate_contingency_1[plate_type]

            if plate_type in numbers_plate_contingency_2:
                plate_type = numbers_plate_contingency_2[plate_type]

        return plate_type

    def parse_plate_type_digit(self, plate):
        plate_type = plate[0]
        if plate[0].isdigit():
            if int(plate[0]) in initial_char_plate_contingency:
                plate_type = initial_char_plate_contingency[int(plate[0])]
        return plate_type

    def parse_plate(self):
        self.plate = self.remove_punctuations(self.plate)
        if len(self.plate) > 0:
          if len(self.plate) > 2:
              plate_type = self.parse_plate_type_digit(self.plate)
              numbers_plate = self.plate[1:7]

              temp_numbers_plate = ""
              index = 0
              for number in numbers_plate:
                  if number.isalpha():
                      if number in numbers_plate_contingency_1:
                          number = numbers_plate_contingency_1[number]
                      if number in numbers_plate_contingency_2:
                          number = numbers_plate_contingency_2[number]
                  temp_numbers_plate += str(number)


              parsed_plate = plate_type + temp_numbers_plate
              return str.upper(parsed_plate)
          else:
              return str(self.parse_plate_type_char(self.plate)) + str(self.plate[1:])
        else:
          return ""

"""
print(SCP_Parser("812-8456").parse_plate())
print(SCP_Parser("1124.456").parse_plate())
print(SCP_Parser("0124I56").parse_plate())
print(SCP_Parser("61244S6").parse_plate())
print(SCP_Parser("3124456").parse_plate())
print(SCP_Parser("5124456").parse_plate())
print(SCP_Parser("2124456").parse_plate())
print(SCP_Parser("A1244O6").parse_plate())
print(SCP_Parser("O1").parse_plate())
"""