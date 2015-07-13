% Should drive forward until distance from an obstacle (wall) is less than
% 20 cm, then turn back from the wall (spin 180).
% Uses IR sensor, 2 large motors.
% Tests macro_turn, macro_forward, sensor_getvalue, motor_init,
% sensor_init.

port = 6789;
ip = '10.0.1.1';
motor_port1 = 'A';
motor_port2 = 'D';
sensor_port = 'S2';

% Initialize controller, motors, and sensor
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port1, 'large');
ctrl.motor_init(motor_port2, 'large');
ctrl.sensor_init(sensor_port, 'ir');

% Go forwards indefinitely
ctrl.macro_forward(motor_port1, motor_port2);

% Keep checking distance, stop if less than 20 cm
d = inf;
while d > 20
    d = ctrl.sensor_getvalue(sensor_port);
end

% Turn back from the obstacle
ctrl.macro_turn(motor_port1, motor_port2, 180);

ctrl.exit()
