% Should spin 720 degrees.
% Uses two large motors.
% Tests macro_turn. Depends on motor_rotate, motor_stop.

port = 6789;
ip = '10.0.1.1';
motor_port1 = 'A';
motor_port2 = 'D';

% Initialize controller and motors
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port1, 'large')
ctrl.motor_init(motor_port2, 'large')

% Sometimes you might want pause after inits since devices take time
% (seconds) to initialize
pause(3);

ctrl.macro_turn(motor_port1, motor_port2, 720, 'IsAsync', 0);

% Since above command is blocking, the line below is executed only after
% it's finished, therefore no visible effect. If 'IsAsync' were set to 1,
% the first wheel would never really spin.
ctrl.motor_stop(motor_port1); 

ctrl.exit();