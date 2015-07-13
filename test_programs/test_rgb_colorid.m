% Should return the id of the color, which in turn should be translated
% into the name of the color (one of 'NONE', 'BLACK', 'BLUE', 'BROWN',
% 'CYAN', 'DARK_GRAY', 'GRAY', 'GREEN', 'LIGHT_GRAY', 'MAGENTA', 'ORANGE',
% 'PINK', 'RED', 'WHITE', 'YELLOW'; should NOT be 'UNKNOWN').
% Uses RGB color sensor.
% Tests sensor_setmode, sensor_init, sensor_getmode, sensor_getvalue,
% color_id_to_str.

port = 6789;
ip = '10.0.1.1';
sensor_port = 'S2';

% Initialize controller and sensors
ctrl = ev3control(port, ip);
ctrl.sensor_init(sensor_port, 'color');

% Set colorid mode
ctrl.sensor_setmode(sensor_port, 'colorid');
mode = ctrl.sensor_getmode(sensor_port); % expect colorid

% Get color ID
colorid = ctrl.sensor_getvalue(sensor_port);

% Get color name
color_name = ctrl.color_id_to_str(colorid);

ctrl.exit();
