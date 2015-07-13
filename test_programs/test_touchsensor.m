% Should return value from the sensor.
% If touch sensor not connected (or something else if connected to that
% port) should display error message on EV3 screen.
% BUT IT DOES NOT! (Because Lejos doesn't throw an exception).

port = 6789;
ip = '10.0.1.1';
sensor_port = 'S4';

% Initialize controller and touch sensor
ctrl = ev3control(port, ip);
ctrl.sensor_init(sensor_port, 'touch');

% Get value
touch = ctrl.sensor_getvalue(sensor_port);

ctrl.exit();