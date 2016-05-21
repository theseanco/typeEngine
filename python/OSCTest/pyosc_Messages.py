from OSC import OSCClient, OSCMessage

client = OSCClient()
client.connect( ("localhost", 7111) )

client.send( OSCMessage("/user/1", [1.0, 2.0] ) )
client.send( OSCMessage("/user/2", [2.0, 3.0] ) )
client.send( OSCMessage("/user/3", [2.0, 3.0] ) )
client.send( OSCMessage("/user/4", [3.2, 3.4] ) )

client.send( OSCMessage("/quit") )
