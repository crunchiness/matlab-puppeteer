% Tests motor tachometer.
% tacho_reading1, tacho_reading2 should be ~1100
% tacho_reading1_reset, tacho_reading2_reset should be 0

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

ctrl.motor_stop(motor_port1);
ctrl.motor_stop(motor_port2);

tacho_reading1 = ctrl.motor_gettacho(motor_port1);
tacho_reading2 = ctrl.motor_gettacho(motor_port2);

ctrl.motor_resettacho(motor_port1)
ctrl.motor_resettacho(motor_port2)

tacho_reading1_reset = ctrl.motor_gettacho(motor_port1);
tacho_reading2_reset = ctrl.motor_gettacho(motor_port2);

ctrl.exit();

% INIT, CLOSE, FORWARD, BACKWARD, STOP, GETTACHO, RESETTACHO, GETSPEED,
% SETSPEED, ROTATE