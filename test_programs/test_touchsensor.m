% Should return value from the sensor.
% If touch sensor not connected (or something else if connected to that
% port) should display error message on EV3 screen.
% BUT IT DOES NOT! Because Lejos doesn't throw an exception.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
sensor_port = 'S4';

ctrl.sensor_init(sensor_port, 'touch');
touch = ctrl.sensor_getvalue(sensor_port);
ctrl.exit();