% Should return values from the sensor in different modes. Check the LED, it
% should switch red-white-red-blue-white throughout the test.
% If color sensor not connected (or something else if connected to that port)
% should display error message on EV3 screen.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
sensor_port = 'S4';

ctrl.sensor_init(sensor_port, 'color');
mode1 = ctrl.sensor_getmode(sensor_port); % expect rgb
rgb = ctrl.sensor_getvalue(sensor_port);

ctrl.sensor_setmode(sensor_port, 'red');
mode2 = ctrl.sensor_getmode(sensor_port); % expect red
red = ctrl.sensor_getvalue(sensor_port);

ctrl.sensor_setmode(sensor_port, 'ambient');
mode3 = ctrl.sensor_getmode(sensor_port); % expect ambient
ambient = ctrl.sensor_getvalue(sensor_port);

ctrl.sensor_setmode(sensor_port, 'rgb')
mode4 = ctrl.sensor_getmode(sensor_port); % expect rgb
rgb2 = ctrl.sensor_getvalue(sensor_port);

ctrl.exit();