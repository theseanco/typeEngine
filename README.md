    This performance is tentatively titled 'typeEngine'. It is a performance in two movements for typist, laptop, mixed microphones, two floppy disk drives and eight relays. Please do get up and have a look at what is going on if you so wish.

    This performance is an implementation of a set of ideas given to me by Professor John Bowers at the start of the module, to severely limit my regular artistic practice. The idea was that I would produce a performance that did not use any sound synthesised in my program of choice, SuperCollider, and ideally write no 'code' during performance.

    I have managed to do both of these things, after a fashion.

    As you can probably hear, I am typing on a mechanical keyboard, and it makes quite a noise. Currently I have mounted a contact microphone onto the bottom of this keyboard, and the sounds being made by my keyboard are being analysed by a program written in SuperCollider. This program determines when an 'onset' (aka keystroke) is detected, and exactly how loud this onset is. 

    When this calculation is performed, the amplitude value is translated into a 'motor speed' value which can be understood by the physical devices you can hear whirring as I type. These values are cued sequentially to an eleven-element list, and overwritten as more values come in. When I press a full stop, translated amplitude values are sent to the Arduino, like so. When this happens, there is a small gap for evaluation, and a new set of sounds emerge based on analysed keystrokes.

    This evaluations work scaled to the devices in question. The two floppy drives range from slow beating to a continuous tone. The eight relays range from four-second clock pulses to continuous switching.

    I can vary the amplitude of the signals by typing, for instance if i type my words very  softly, the motor speeds should be quite slow. OR IF I TYPE REALLY LOUD THEY SHOULD BE QUITE FAST :). However these keystrokes as I normally type are pretty variable, which result in many rhythmic combinations.

    In this way, I have accidentally designed a live coding environment which interprets words as I type them and uses a full stop as an 'execution' signal.

    As I type this, the first part of the performance is coming to a close, but first I will explain part two.

    For part two of this performance I will activate a second script written in SuperCollider which analyses the fundamental pitch of the mechanical sounds playing and turns it into a value. This value is then used to decide on one particular word of this script, and then type this value back into this document at roughly the same rate (words per minute) that I typed at during a rehearsal of part one (using an analysis program).

    Just as in part one, if a word written contains a full stop, amplitude values will be sent on to the Arduino, changing the way the actuators sound. I will remove the microphone on the bottom of my keyboard and place it on the table, applying the same amplitude analysis I performed on my keyboard to the sounds of these physical actuators. If this sounds confusing, that's because it kinda is, but essentially what is going to happen is I will complete a feedback loop which makes the computer re-compose this text based on the frequency of the sounds produced, and obeying the rules of part one of this performance. Throughout part 2 I will manipulate the mixing of the sound, partly to showcase the subtleties of the sounds being produced, but also to coax the program out of any potential equilibrium which would result in a word becoming stuck.

    The program will write the same number of words that are in this text, and then stop.

    Thank you.
