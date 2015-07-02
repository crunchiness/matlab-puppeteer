% Tests sensor closing and initialising antoher on the same port.
% Should return values from sensors.
% First color sensor needs to be connected. Then you need to replace it
% with IR sensor when prompted.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
sensor_port = 'S4';

ctrl.sensor_init(sensor_port, 'color');
rgb = ctrl.sensor_getvalue(sensor_port);
ctrl.sensor_close(sensor_port);

display('Replace color sensor with IR sensor now.');
pause(10);

ctrl.sensor_init(sensor_port, 'ir');
ir = ctrl.sensor_getvalue(sensor_port);
ctrl.sensor_close(sensor_port);
ctrl.exit();