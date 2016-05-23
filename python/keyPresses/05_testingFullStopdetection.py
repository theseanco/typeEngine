import pyautogui
import random
from pykeyboard import PyKeyboard


keyboard = PyKeyboard()

# q = open("words.txt","r")
words = open("words.txt","r").read().split()
randword = random.choice(words)

if '.' in randword:
    randword.replace('.','')
    print randword
    keyboard.type_string('.')
else:
    pyautogui.typewrite(randword + ' ')
