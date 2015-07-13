% Should beep, buzz, and exit.

port = 6789;
ip = '10.0.1.1';

% Initialize controller
ctrl = ev3control(port, ip);

% Send commands
ctrl.beep();
ctrl.buzz();

% Exit
ctrl.exit();
