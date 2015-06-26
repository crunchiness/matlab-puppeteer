port = 6789;
ip = '10.0.1.1';
%ip = '127.0.0.1';
ctrl = ev3control(port, ip);
ctrl.sensor_init('S4');
distance = ctrl.sensor_getdistance('S4');
%ctrl.exit();
%ctrl.motor_init('A');
%speed = ctrl.motor_getspeed('A');
%ctrl.motor_init('D');
%ctrl.motor_backward('A');
%ctrl.motor_forward('D');

%clien = tcpip(ip, port);
%fopen(clien);
%fwrite(clien, sprintf('aaaaaa\n'));
%A = fread(clien, 9);
%fclose(clien);
%sprintf('%s', A)
%t = tcpclient(ip, port);
%write(t, 'aaaaaaaaaaaaaaa');
%A = read(t);