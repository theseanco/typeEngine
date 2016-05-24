import pyautogui
import random

# q = open("words.txt","r")
words = open("words.txt","r").read().split()
pyautogui.typewrite(random.choice(words) + ' ')
