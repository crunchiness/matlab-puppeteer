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

###### sensor_init - intializes sensor. This command has to be executed before any other sensor command.

Params:

1. sensor_port (possible values 'S1', 'S2', 'S3', 'S4')
2. sensor_type (possible values 'color', 'ir', 'touch')

Example:
```
ctrl.sensor_init('S1', 'color');
```
===============
###### sensor_close - closes sensor. When sensor is closed, you can no longer send any commands to it; can initialize again (perhaps unplug one and plug in different), and it doesn't consume power. There is no need to close devices before exit command.

Params:

1. sensor_port (possible values 'S1', 'S2', 'S3', 'S4')

Example:
```
ctrl.sensor_close('S1');
```
===============
###### sensor_getvalue - get a reading from the sensor (same for any type of sensor)

Params:

1. sensor_port (possible values 'S1', 'S2', 'S3', 'S4')

Returns:
value - array of value (most often 1 value, RGB sensor returns array of 3 values).

Example:
```
value = ctrl.sensor_getvalue('S2');
```
===============
###### sensor_setmode - sets sensor's mode. Some sensors have multiple modes, e. g. color sensor has RGB, red light, and ambient light, and color id modes.

Defaults:

1. RGB mode for color sensor
2. Distance mode for IR sensor
3. Touch mode for touch sensor

Params:

1. sensor_port (possible values 'S1', 'S2', 'S3', 'S4')
2. sensor_mode (possible values: for color sensor: 'rgb', 'red', 'ambient', 'colorid'; for IR sensor: 'distance'; for touch sensor: 'touch')

Example:
```
ctrl.sensor_setmode('S3', 'red');
```
Note: color of LED light will change only upon sensor_getvalue command.

===============
###### sensor_getmode - retrieves sensor's mode.

Params:

1. sensor_port (possible values 'S1', 'S2', 'S3', 'S4')

Returns:
mode - string, possible values: 'rgb', 'red', 'ambient', 'colorid', 'distance', 'touch'.

Example:
```
mode = ctrl.sensor_getmode('S3');
```
===============
###### color_id_to_str - converts color id (retrieved from color sensor in color id mode as an integer value) to string.

Params:

1. color_id (integer 0-7)

Returns:
id_str - string, possible values: 'NONE', 'BLACK', 'BLUE', 'GREEN', 'YELLOW', 'RED', 'WHITE', 'BROWN', 'UNKNOWN'.

Exampe:
```
id_str = ctrl.color_id_to_str(2);
```

#### Camera

###### camera_init - intializes camera. This command has to be executed before any other camera command.

Optional:
- Width (width of resolution, default: 176)
- Height (height of resolution, default: 144)

Examples:
```
ctrl.camera_init();
ctrl.camera_init('Width', 160, 'Height', 120);
```
===============
###### camera_close - closes camera. When camera is closed, you can no longer send any commands to it; can initialize again. There is no need to close devices before exit command.

Example:
```
ctrl.camera_close();
```
===============
###### camera_takepic - take a picture and returns it as MATLAB array.

Optional:
- Normalize (normalize values from range 0-255 to 0.0-1.0, so that Matlab can display the image; possible values: 0 (don't normalize), 1 (normalize); default: 0)

Examples:
```
pic1 = ctrl.camera_takepic();               % values 0-255
pic2 = ctrl.camera_takepic('Normalize', 1); % values 0.0-1.0
imshow(pic2);                               % pic2 is displayable 
```

#### Macros
Macros are functions that use the functions above, providing two-wheel motions. This assumes that robot is based on [Lego Mindstorms EV3 Track3r](http://www.lego.com/en-gb/mindstorms/build-a-robot/track3r) chassis.

###### macro_forward - sends "forward" command to both wheels.

Params:

1. motor_port1 (possible values 'A', 'B', 'C', 'D')
2. motor_port2 (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.macro_forward('A', 'D');
```
===============
###### macro_backward - sends "backward" command to both wheels.

Params:

1. motor_port1 (possible values 'A', 'B', 'C', 'D')
2. motor_port2 (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.macro_backward('A', 'D');
```
===============
###### macro_stop - sends "stop" command to both wheels. Can be used to stop all asynchronous motor movement commands.

Params:

1. motor_port1 (possible values 'A', 'B', 'C', 'D')
2. motor_port2 (possible values 'A', 'B', 'C', 'D')

Example:
```
ctrl.macro_stop('A', 'D');
```
===============
###### macro_rotate - sends "rotate" command to both wheels (both wheels rotate by the same angle).

Params:

1. motor_port1 (possible values 'A', 'B', 'C', 'D')
2. motor_port2 (possible values 'A', 'B', 'C', 'D')
3. degrees (angle in degrees that each wheel should turn by)

Optional:
- IsAsync (possible values: 0 (synchronous), 1 (asynchronous); default: 1)

Example:
```
ctrl.macro_rotate('A', 'D', 720, 'IsAsync', 0); % rotate both wheels by 720 degrees, blocking
```
===============
###### macro_turn - rotate vehicle by some angle in degrees, in place.

Params:

1. motor_port1 (possible values 'A', 'B', 'C', 'D')
2. motor_port2 (possible values 'A', 'B', 'C', 'D')
3. degrees (angle in degrees that each wheel should turn by)


Optional:
- WheelDistance (distance between wheels in cm, default: 20.5)
- WheelRadius (wheel radius in cm, default: 1.75)
- IsAsync (possible values: 0 (synchronous), 1 (asynchronous); default: 1)

Examples:
```
ctrl.macro_turn('A', 'D', 360); % spin around, asynchronous
ctrl.macro_turn('A', 'D', 360, 'IsAsync', 0, 'WheelDistance', 20, 'WheelRadius', 2.1); % spin around, blocking
```

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

