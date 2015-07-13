% Should spin one wheel one revolution.
% Uses one large motor.
% Tests motor_rotate.

port = 6789;
ip = '10.0.1.1';
motor_port = 'A';

% Initialize controller and motor.
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port, 'large');

ctrl.motor_rotate(motor_port, 360, 'IsAsync', 0);

% Since above command is blocking, the line below is executed only after
% it's finished, therefore no visible effect. If 'IsAsync' were set to 1,
% the wheel would never really spin.
ctrl.motor_stop(motor_port);

ctrl.exit();
