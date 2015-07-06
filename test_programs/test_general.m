% Should beep, buzz, and exit.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.beep();
ctrl.buzz();
ctrl.exit();