% Should go forward for 3 seconds, then go backward for 3 seconds while
% turning (one wheel goes 2x slower).
% Uses 2 large motors.
% Tests motor_init, motor_forward, motor_backward, motor_stop, motor_close,
% motor_getspeed, motor_setspeed.

port = 6789;
ip = '10.0.1.1';
motor_port1 = 'A';
motor_port2 = 'D';

% Initialize controller and motors
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port1, 'large')
ctrl.motor_init(motor_port2, 'large')

% Pause to make sure initialization of BOTH wheels is complete when the
% next commands are sent, so that both wheels start spinning at once.
pause(3);

ctrl.motor_forward(motor_port1);
ctrl.motor_forward(motor_port2);

% motor_forward will spin wheels for 3 seconds
pause(3);
ctrl.motor_stop(motor_port1);
ctrl.motor_stop(motor_port2);

% Get speed, and set to half as fast
speed = ctrl.motor_getspeed(motor_port1);
ctrl.motor_setspeed(motor_port1, speed/2);

ctrl.motor_backward(motor_port1);
ctrl.motor_backward(motor_port2);

% Backward for 3 seconds
pause(3);

ctrl.motor_stop(motor_port1);
ctrl.motor_stop(motor_port2);

% Closing here is not necessary
ctrl.motor_close(motor_port1);
ctrl.motor_close(motor_port2);

ctrl.exit();
