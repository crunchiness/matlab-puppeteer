###### matlab-puppeteer

This is a client program for <link>. Using matlab-puppeteer one can write
programs for Lego EV3 robot, running leJOS and <name>. Programs are
executed in Matlab and commands are sent to <name> (normally via
bluetooth).

### Advantages
Advantage of this approach over Matlab support package for EV3:
- Linux support (read more <here>).
- <name> supports webcam.
- <name> can be customised relatively easily, for example, to support other
devices.
- Communication between server <name> and client (matlab-puppeteer) happens
via JSON requests and responses -- meaning that one doesn't necessarily
have to use matlab-puppeteer to command <name>.

### Documentation

## Initialization
You need to know the port number and IP address of the EV3 brick. Port
number in <name> is hardcoded as 6789. You can find IP address of the brick
on the brick once it has been connected to PC (usually 10.0.1.1).

Then to initialize:

```ctrl = ev3control(port, ip);```

All the commands to the robot will be sent through ctrl controller object,
e. g. ```ctrl.motor_init(motor_port1, 'large');```

## Functions

# General
===========
beep - brick makes a beep sound.
Example:
```ctrl.beep()```
===========
buzz - brick makes a buzz sound.
Example:
```ctrl.buzz()```
===========
exit - exits the main <name> program
Example:
```ctrl.exit()```
===========
# Motor
===========



# Sensor

# Camera


## Dependencies and building
This program depends on JSONlab (however, you only need to do something
about it if you are building the toolbox from source)

## Notes
- When color sensor is in "colorid" mode getvalue returns id 0-7. Use
controller's function "color_id_to_str" to get the name of the color.
- Blocking (synchronous) commands will wait no longer than 120 seconds
(for example, if your robot drives forward in blocking rotate mode, after
120 seconds, the next command will be sent even if it still hasn't rotated
the specified number of degrees).