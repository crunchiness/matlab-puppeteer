% Tests motor tachometer.
% tacho_reading1, tacho_reading2 should be ~1100
% tacho_reading1_reset, tacho_reading2_reset should be 0

port = 6789;
ip = '10.0.1.1';
motor_port1 = 'A';
motor_port2 = 'D';

% Initialize controller and motors
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port1, 'large');
ctrl.motor_init(motor_port2, 'large');

% Make sure they are BOTH initialized upon forward commands
pause(3);

ctrl.motor_forward(motor_port1);
ctrl.motor_forward(motor_port2);

% Go forwards for 3 seconds
pause(3);
ctrl.motor_stop(motor_port1);
ctrl.motor_stop(motor_port2);

% Get tachometer readings (should be ~~roughly~~ the same)
% For better synchronization the lejos-server program should be modified.
tacho_reading1 = ctrl.motor_gettacho(motor_port1);
tacho_reading2 = ctrl.motor_gettacho(motor_port2);

% Reset tachometers
ctrl.motor_resettacho(motor_port1)
ctrl.motor_resettacho(motor_port2)

% Read tacho values, should be 0
tacho_reading1_reset = ctrl.motor_gettacho(motor_port1);
tacho_reading2_reset = ctrl.motor_gettacho(motor_port2);

ctrl.exit();
