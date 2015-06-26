port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.sensor_init('S3', 'color');
rgb = ctrl.sensor_getvalue('S3');
ctrl.sensor_close('S3');

display('replace color sensor with IR sensor now');
pause(10);

ctrl.sensor_init('S3', 'ir');
ir = ctrl.sensor_getvalue('S3');
ctrl.sensor_close('S3');