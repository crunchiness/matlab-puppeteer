port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.sensor_init('S3', 'color');
mode1 = ctrl.sensor_getmode('S3'); % expect rgb
rgb = ctrl.sensor_getvalue('S3');

ctrl.sensor_setmode('S3', 'red');
mode2 = ctrl.sensor_getmode('S3'); % expect red
red = ctrl.sensor_getvalue('S3');

ctrl.sensor_setmode('S3', 'ambient');
mode3 = ctrl.sensor_getmode('S3'); % expect ambient
ambient = ctrl.sensor_getvalue('S3');

ctrl.sensor_setmode('S3', 'rgb')
mode4 = ctrl.sensor_getmode('S3'); % expect rgb
rgb2 = ctrl.sensor_getvalue('S3');