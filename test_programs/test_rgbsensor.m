% Should return values from the sensor in different modes. Check the LED, it
% should switch red-white-red-blue-white throughout the test.
% If color sensor not connected (or something else if connected to that port)
% should display error message on EV3 screen.
% Uses rgb sensor.

port = 6789;
ip = '10.0.1.1';
sensor_port = 'S4';

% Initialize controller and sensor
ctrl = ev3control(port, ip);
ctrl.sensor_init(sensor_port, 'color');

mode1 = ctrl.sensor_getmode(sensor_port); % expect rgb

% Get RGB value (rgb mode default)
rgb = ctrl.sensor_getvalue(sensor_port);

% Set red mode
ctrl.sensor_setmode(sensor_port, 'red');
mode2 = ctrl.sensor_getmode(sensor_port); % expect red

% Get red value
red = ctrl.sensor_getvalue(sensor_port);

% Set ambient mode
ctrl.sensor_setmode(sensor_port, 'ambient');
mode3 = ctrl.sensor_getmode(sensor_port); % expect ambient

% Get ambient value
ambient = ctrl.sensor_getvalue(sensor_port);

% Set rgb mode
ctrl.sensor_setmode(sensor_port, 'rgb')
mode4 = ctrl.sensor_getmode(sensor_port); % expect rgb

% Get rgb value
rgb2 = ctrl.sensor_getvalue(sensor_port);

ctrl.exit();
