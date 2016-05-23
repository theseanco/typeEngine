from subprocess import Popen, PIPE

fullstop_sequence = '''
key Decimal
'''

def keypress(sequence):
    p = Popen(['xte'], stdin=PIPE)
    p.communicate(input=sequence)

keypress(fullstop_sequence)
