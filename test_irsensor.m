port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.sensor_init('S4', 'ir');
rgb = ctrl.sensor_getvalue('S4');
ctrl.exit();