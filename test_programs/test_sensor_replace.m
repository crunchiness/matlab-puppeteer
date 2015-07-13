% Should return values from sensors.
% Tests sensor closing and initialising antoher on the same port.
% First color sensor needs to be connected. Then you need to replace it
% with IR sensor when prompted.

port = 6789;
ip = '10.0.1.1';
sensor_port = 'S4';

% Initialize controller and color sensor
ctrl = ev3control(port, ip);
ctrl.sensor_init(sensor_port, 'color');

% Get rgb value
rgb = ctrl.sensor_getvalue(sensor_port);

% Close sensor, so we can attach another (thus no need to exit the program)
ctrl.sensor_close(sensor_port);

display('Replace color sensor with IR sensor now.');
pause(10);

% Initialize ir sensor in place of rgb
ctrl.sensor_init(sensor_port, 'ir');

% Get distance value
ir = ctrl.sensor_getvalue(sensor_port);

ctrl.exit();
