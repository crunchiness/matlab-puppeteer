port = 6789;
ip = '10.0.1.1';
%ip = '127.0.0.1';
ctrl = ev3control(port, ip);
ctrl.motor_init('A');
ctrl.motor_init('D');
ctrl.motor_backward('A');
ctrl.motor_forward('D');
