% Should return the id of the color, which in turn should be translated
% into the name of the color (one of 'NONE', 'BLACK', 'BLUE', 'BROWN',
% 'CYAN', 'DARK_GRAY', 'GRAY', 'GREEN', 'LIGHT_GRAY', 'MAGENTA', 'ORANGE',
% 'PINK', 'RED', 'WHITE', 'YELLOW'; should NOT be 'UNKNOWN').
% Requires RGB color sensor

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
sensor_port = 'S2';

ctrl.sensor_init(sensor_port, 'color');
ctrl.sensor_setmode(sensor_port, 'colorid');
mode = ctrl.sensor_getmode(sensor_port); % expect colorid
colorid = ctrl.sensor_getvalue(sensor_port);
color_name = ctrl.color_id_to_str(colorid);

ctrl.exit();