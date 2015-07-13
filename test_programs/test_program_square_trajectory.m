% Should drive around in a square trajectory, assuming correct wheel
% distance and wheel radius params.
% Uses two large motors.
% Tests macro_rotate, macro_turn.

port = 6789;
ip = '10.0.1.1';

motor_port1 = 'A';
motor_port2 = 'D';

% Initialize controller and motors
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port1, 'large');
ctrl.motor_init(motor_port2, 'large');

% Drive
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);

ctrl.exit();
