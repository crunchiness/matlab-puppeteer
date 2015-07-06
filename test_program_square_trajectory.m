% Tests macro_rotate, macro_turn.
% Should drive around in a square trajectory, assuming correct wheel
% distance and wheel radius params.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
motor_port1 = 'A';
motor_port2 = 'D';

ctrl.motor_init(motor_port1, 'large');
ctrl.motor_init(motor_port2, 'large');

ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);
ctrl.macro_rotate(motor_port1, motor_port2, 1000, 'IsAsync', 0);
ctrl.macro_turn(motor_port1, motor_port2, 90, 'IsAsync', 0);

ctrl.exit();