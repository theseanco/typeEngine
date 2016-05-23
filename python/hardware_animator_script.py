"""OSC Test Script
Written by Aaron Chamberlain Dec. 2013
The purpose of this script is to make a very simple communication structure to the popular
application touchOSC. This is achieved through the pyOSC library. However, since the pyOSC
documentation is scarce and only one large example is included, I am going to strip down
the basic structures of that file to implement a very simple bi-directional communication.
"""

# This is an edited version of the original example, getting rid of the passing-on code.

#!/usr/bin/env python

import socket, OSC, re, time, threading, math, serial

receive_address = '127.0.0.1', 7001 #Mac Adress, Outgoing Port

class PiException(Exception):
	def __init__(self, value):
		self.value = value
	def __str__(self):
		return repr(self.value)

##########################
#	OSC
##########################

# Initialize the OSC server and the client.
s = OSC.OSCServer(receive_address)
s.addDefaultHandlers()
# adding serial interface with Arduino
arduino = serial.Serial('/dev/ttyACM0',115200)

# define a message-handler function for the server to call.
def test_handler(addr, tags, stuff, source):
	print "---"
	print "received new osc msg from %s" % OSC.getUrlStr(source)
	print "with addr : %s" % addr
	print "typetags %s" % tags
	print "data %s" % stuff
	msg = OSC.OSCMessage()
	msg.setAddress(addr)
	msg.append(stuff)
	print "return message %s" % msg
	print "---"

# a function to grab all of the info and format it out as best as possible
# i've added the function from OSCarraytostring to it
def soundInfo_handler(add, tags, stuff, source):
	print "message recieved:"
	formattedData = ' '.join(map(str,stuff))
	print(formattedData)
	arduino.write(formattedData)




# adding my functions
s.addMsgHandler("/soundInfo/array", soundInfo_handler)
# just checking which handlers we have added
print "Registered Callback-functions are :"
for addr in s.getOSCAddressSpace():
	print addr

# Start OSCServer
print "\nStarting OSCServer. Use ctrl-C to quit."
st = threading.Thread( target = s.serve_forever )
st.start()

# Loop while threads are running.
try :
	while 1 :
		time.sleep(10)

except KeyboardInterrupt :
	print "\nClosing OSCServer."
	s.close()
	print "Waiting for Server-thread to finish"
	st.join()
	print "Done"
