% Uses IR sensor, drives until distance from an obstacle (wall) is less
% than 20 cm.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
motor_port1 = 'A';
motor_port2 = 'D';
sensor_port = 'S2';

ctrl.motor_init(motor_port1, 'large');
ctrl.motor_init(motor_port2, 'large');
ctrl.sensor_init(sensor_port, 'ir');

ctrl.macro_forward(motor_port1, motor_port2);

d = inf;

while d > 20
    d = ctrl.sensor_getvalue(sensor_port);
end

ctrl.macro_turn(motor_port1, motor_port2, 180, 'IsAsync', 0);

ctrl.camera_init();
picture_norm = ctrl.camera_takepic('Normalize', 1);
imshow(picture_norm);

ctrl.exit();