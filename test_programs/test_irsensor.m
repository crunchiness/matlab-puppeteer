% Should return value from the sensor.
% If IR sensor not connected (or something else is connected to that port)
% should display error message on EV3 screen.
% Uses IR sensor.
% Tests sensor_init, sensor_getvalue.

port = 6789;
ip = '10.0.1.1';
sensor_port = 'S4';

% Initialize controller and sensor.
ctrl = ev3control(port, ip);
ctrl.sensor_init(sensor_port, 'ir');

% Get value from sensor.
value = ctrl.sensor_getvalue(sensor_port);

ctrl.exit();