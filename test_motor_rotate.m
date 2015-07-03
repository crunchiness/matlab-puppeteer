% Tests motor rotate action.
% Should go forward one wheel revolution, synchronously.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
motor_port1 = 'A';
motor_port2 = 'D';

ctrl.motor_init(motor_port1, 'large')
ctrl.motor_init(motor_port2, 'large')

pause(3);

ctrl.motor_rotate(motor_port1, 720, 0);
ctrl.motor_stop(motor_port1);

% 
% ctrl.motor_rotate(motor_port1, 720);
% ctrl.motor_rotate(motor_port1, 720);
% ctrl.motor_rotate(motor_port1, 720);
% ctrl.motor_rotate(motor_port2, 720);
% pause(1);
% % ctrl.motor_backward(motor_port1);
% % ctrl.motor_backward(motor_port2);
% pause(2);
% ctrl.motor_stop(motor_port1);
% ctrl.motor_stop(motor_port2);
% ctrl.exit();

% INIT, CLOSE, FORWARD, BACKWARD, STOP, GETTACHO, RESETTACHO, GETSPEED,
% SETSPEED, ROTATE