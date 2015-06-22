port = 6789;
%ip = '10.0.1.1';
ip = '127.0.0.1';
ctrl = ev3control(port, ip);
ctrl.motor('A', 360);
ctrl.motor('D', 360);
ctrl.exit();
