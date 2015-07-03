% Tests motor_init, motor_forward, motor_backward, motor_stop, motor_close,
% motor_getspeed, motor_setspeed.
% Should go forward for 3 seconds, then go backward for 3 seconds while
% turning (one wheel goes 2x slower).

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
motor_port1 = 'A';
motor_port2 = 'D';

ctrl.motor_init(motor_port1, 'large')
ctrl.motor_init(motor_port2, 'large')

pause(3);

ctrl.motor_forward(motor_port1);
ctrl.motor_forward(motor_port2);

pause(3);

speed = ctrl.motor_getspeed(motor_port1);
ctrl.motor_setspeed(motor_port1, speed/2);

ctrl.motor_backward(motor_port1);
ctrl.motor_backward(motor_port2);

pause(3);

ctrl.motor_stop(motor_port1);
ctrl.motor_stop(motor_port2);

ctrl.motor_close(motor_port1);
ctrl.motor_close(motor_port2);

ctrl.exit();

% INIT, CLOSE, FORWARD, BACKWARD, STOP, GETTACHO, RESETTACHO, GETSPEED,
% SETSPEED, ROTATE