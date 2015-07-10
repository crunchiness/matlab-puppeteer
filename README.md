matlab-puppeteer
===============

This is a client program for [lejos-server](https://github.com/crunchiness/lejos-server). Using matlab-puppeteer one can write
programs for Lego EV3 robot, running leJOS and lejos-server. Programs are
executed in Matlab and commands are sent to lejos-server (normally via
bluetooth).

## Advantages
Advantage of this approach over Matlab support package for EV3:
+ Linux support (read more <here>).
+ lejos-server supports webcam.
+ lejos-server can be customised relatively easily, for example, to support other
devices.
+ Communication between server lejos-server and client (matlab-puppeteer) happens
via JSON requests and responses -- meaning that one doesn't necessarily
have to use matlab-puppeteer to command lejos-server.

## Documentation

### Initialization
You need to know the port number and IP address of the EV3 brick. Port
number in lejos-server is hardcoded as 6789. You can find IP address of the brick
on the brick once it has been connected to PC (usually 10.0.1.1).

Then to initialize:

```ctrl = ev3control(port, ip);```

All the commands to the robot will be sent through ctrl controller object,
e. g. ```ctrl.motor_init(motor_port1, 'large');```

### Functions

#### General

###### beep - brick makes a beep sound.
Example:
```
ctrl.beep()
```
===============
###### buzz - brick makes a buzz sound.
Example:
```
ctrl.buzz()
```
===============
###### exit - exits the main lejos-server program
Example:
```
ctrl.exit()
```
===============
#### Motor

###### motor_init - intializes motor. This command has to be executed before any other motor command.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')
2. type (possible values 'medium', 'large')

Example
```
ctrl.motor_init('A', 'large');
```
===============
###### motor_close - closes motor. When motor is closed, you can no longer send any commands to it; can initialize again (perhaps unplug one and plug in different), and it doesn't consume power. There is no need to close devices before exit command.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.motor_close('B');
```
===============
###### motor_forward - motor starts spinning forwards, stops only when stop command is received. Asynchronous.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.motor_forward('D');
```
===============
###### motor_backward - motor starts spinning backwards, stops only when stop command is received. Asynchronous.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.motor_backward('B');
```
===============
###### motor_stop - stops the motor (works on motor_forward, motor_backward, and asynchronous motor_rotate)

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.motor_stop('A');
```
===============
###### motor_gettacho - retrieves a reading from motor's tachometer (how many degrees it has turn).

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Returns:
reading - integer reading in degrees, how many degrees has the motor spinned.

Example:
```
tacho_reading = ctrl.motor_gettacho('A');
```
===============
###### motor_resettacho - resets motor's tachometer to zero.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.motor_resettacho('A');
```
===============
###### motor_getspeed - get the speed of the motor, in degrees per ?. Default 360.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')

Returns:
speed - integer speed degrees per ?.

Example:
```
speed = ctrl.motor_getspeed('A');
```
===============
###### motor_setspeed - set the speed of the motor, in degrees per ?.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')
2. speed (integer)

Example:
```
ctrl.motor_setspeed('A', 180);
```
===============
###### motor_rotate - rotate a specified number of degrees.

Params:

1. motor_port (possible values 'A', 'B', 'C', 'D')
2. degrees (integer)

Optional:
- IsAsync (possible values: 0 (synchronous), 1 (asynchronous); default: 1)

Example:
```
ctrl.motor_rotate('A', 720, 'IsAsync', 0); % rotate motor A by 720 degrees, blocking
```
===============

#### Sensor

#### Camera


## Dependencies and building
This program depends on JSONlab (however, you only need to do something
about it if you are building the toolbox from source)

## Synchronous (blocking) vs asynchronous commands

## Notes
+ When color sensor is in "colorid" mode getvalue returns id 0-7. Use
controller's function "color_id_to_str" to get the name of the color.
+ Blocking (synchronous) commands will wait no longer than 120 seconds
(for example, if your robot drives forward in blocking rotate mode, after
120 seconds, the next command will be sent even if it still hasn't rotated
the specified number of degrees).
+ Initialization commands take a few seconds, you probably want to initialize all devices at the start of the program.

