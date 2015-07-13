% Should drive around in trajectory of the "8" shape.
% Uses two large motors.
% Tests motor_setspeed, motor_getspeed, motor_rotate, macro_rotate.

port = 6789;
ip = '10.0.1.1';
motor_port1 = 'A';
motor_port2 = 'D';
WD = 20.5;      % distance between wheels
r = 17.5;       % radius of "8" loop
WR = 1.75;      % wheel radius
alpha = 90;     % 1-90, lower degrees make "8" longer

% Calculate degrees to rotate each wheel
degrees_outer = round((180+(2*alpha)) * (WD + r) / WR);
degrees_inner = round((180+(2*alpha)) * (r / WR));

% Calculate straight distance to where the next loop starts
% 0 if alpha = 90
straight_dist = round((cot(degtorad(alpha)) * r * 360) / (pi * WR));

% Initialize controller and the motors
ctrl = ev3control(port, ip);
ctrl.motor_init(motor_port1, 'large');
ctrl.motor_init(motor_port2, 'large');

% Calculate slower speed based on the current default
speed = ctrl.motor_getspeed(motor_port1);
inner_wheel_speed = round(r * speed / (WD + r));

% Do the first loop
ctrl.motor_setspeed(motor_port1, inner_wheel_speed);
ctrl.motor_rotate(motor_port1, degrees_inner);
ctrl.motor_rotate(motor_port2, degrees_outer, 'IsAsync', 0);

% Drive the straight
ctrl.motor_setspeed(motor_port1, speed);
ctrl.macro_rotate(motor_port1, motor_port2, straight_dist, 'IsAsync', 0);

% Do the second loop
ctrl.motor_setspeed(motor_port2, inner_wheel_speed);
ctrl.motor_rotate(motor_port2, degrees_inner);
ctrl.motor_rotate(motor_port1, degrees_outer, 'IsAsync', 0);

% Drive the second straight
ctrl.motor_setspeed(motor_port2, speed);
ctrl.macro_rotate(motor_port1, motor_port2, straight_dist, 'IsAsync', 0);

ctrl.exit();
