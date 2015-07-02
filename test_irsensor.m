% Should return value from the sensor.
% If IR sensor not connected (or something else if connected to that port)
% should display error message on EV3 screen.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.sensor_init('S4', 'ir');
value = ctrl.sensor_getvalue('S4');
ctrl.exit();