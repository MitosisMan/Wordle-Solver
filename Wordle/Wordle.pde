import tkinter as tk
from tkinter import filedialog
import os
import time
import datetime

#Select your folder here
dir = 'C:/Users/evank/OneDrive/Desktop/Test'

def select_file():
    filepath = filedialog.askdirectory()
    print(filepath)
    
now = time.time()

    
def deleteFiles(yearInt, monthInt, weekInt, dayInt, hourInt, minuteInt, keywordExlusion, typeExclusion):
    if yearInt == "":
        yearInt = 0
        
    if monthInt == "":
        monthInt = 0
        
    if weekInt == "":
        weekInt = 0
     
    if dayInt == "":
        dayInt = 0
        
    if hourInt == "":
        hourInt = 0   
        
    if minuteInt == "":
        minuteInt = 0  
    
    minuteInt = int(minuteInt)
    hourInt = int(hourInt)
    dayInt = int(dayInt)
    weekInt = int(weekInt)
    monthInt = int(monthInt)
    yearInt = int(yearInt)
    
    print(keywordExlusion, typeExclusion)
    print(yearInt, monthInt, weekInt, dayInt, hourInt, minuteInt, keywordExlusion, typeExclusion)
    if keywordExlusion == 'null':
        keywordExlusion = ""
    if typeExclusion == 'null':
        typeExclusion = ""
    files = os.listdir(dir)
    listOfKeywordExlusions = keywordExlusion.split(",")
    listOfTypeExclusions = typeExclusion.split(",")
    
    for file in files:
        file_path = os.path.join(dir, file)
        last_modified = os.path.getmtime(file_path)
        last_modified_readable = datetime.datetime.fromtimestamp(last_modified).strftime('%Y-%m-%d %H:%M:%S')
        difference = now - last_modified

        print(difference)
        
        if difference > 60*minuteInt + 60*60*hourInt + 60*60*24*dayInt + 60*60*24*7*weekInt + 60*60*24*30*monthInt + 60*60*24*365*yearInt:
            # file name with extension
            file_name = os.path.basename(file_path)
            
            if not(os.path.splitext(file_name)[0] in listOfKeywordExlusions) and not(os.path.splitext(file_name)[1] in listOfTypeExclusions):
                print("Deleting " + file_path + " because it was last modified at " + last_modified_readable)
                os.remove(file_path)
       


def on_button_click():
    print(var1.get(), var2.get())

root = tk.Tk()
root.title("Storage Saver")

options = {"Option 1": 1, "Option 2": 2, "Option 3": 3}

root.geometry("500x300")

var1 = tk.StringVar(value="File Directory")
var2 = tk.StringVar(value="Time")

# dropdown1 = tk.OptionMenu(root, var1, *options)
# dropdown1.pack()





# dropdown = tk.OptionMenu(root, var2, "older", "younger", variable = var2)
# dropdown.grid(row=0, column=4)



time_label = tk.Label(root, text="Time")
time_label.grid(row=1, column=0)

yearsInput = tk.Entry(root)
yearsInput.grid(row=1, column=1)

yearsLabel = tk.Label(root, text="years")
yearsLabel.grid(row=1, column=2)

monthsInput = tk.Entry(root)
monthsInput.grid(row=2, column=1)

monthsLabel = tk.Label(root, text="months")
monthsLabel.grid(row=2, column=2)

weeksInput = tk.Entry(root)
weeksInput.grid(row=3, column=1)

weeksLabel = tk.Label(root, text="weeks")
weeksLabel.grid(row=3, column=2)

daysInput = tk.Entry(root)
daysInput.grid(row=4, column=1)

daysLabel = tk.Label(root, text="days")
daysLabel.grid(row=4, column=2)

hoursInput = tk.Entry(root)
hoursInput.grid(row=5, column=1)

hoursLabel = tk.Label(root, text="hours")
hoursLabel.grid(row=5, column=2)

minutesInput = tk.Entry(root)
minutesInput.grid(row=6, column=1)

minutesLabel = tk.Label(root, text="minutes")
minutesLabel.grid(row=6, column=2)


keywordInput = tk.Entry(root)
keywordInput.grid(row=8, column=1)

KeywordLabel = tk.Label(root, text="Keywords")
KeywordLabel.grid(row=8, column=2)

typeInput = tk.Entry(root)
typeInput.grid(row=9, column=1)

typeLabel = tk.Label(root, text="File Type")
typeLabel.grid(row=9, column=2)

button = tk.Button(root, text="Submit", command=lambda: deleteFiles(yearsInput.get(), monthsInput.get(), weeksInput.get(), daysInput.get(), hoursInput.get(), minutesInput.get(), keywordInput.get(), typeInput.get()))
button.grid(row=7,column=2)

# dropdown2 = tk.OptionMenu(root, var2, "Option A", "Option B", "Option C")
# dropdown2.pack()







# hours_label = tk.Label(root, text="hours")
# hours_label.grid(row=0, column=2)

# minutes_input = tk.Entry(root)
# minutes_input.grid(row=0, column=3)

# minutes_label = tk.Label(root, text="minutes")
# minutes_label.grid(row=0, column=4)

root.mainloop()
