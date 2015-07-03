% Should spin 720 degrees.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
motor_port1 = 'A';
motor_port2 = 'D';

ctrl.motor_init(motor_port1, 'large')
ctrl.motor_init(motor_port2, 'large')

pause(3);

ctrl.macro_turn(motor_port1, motor_port2, 720, 'IsAsync', 0);
ctrl.motor_stop(motor_port1);