port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.camera_init();
picture = ctrl.camera_takepic();
picture_norm = ctrl.camera_takepic('norm');
imshow(picture_norm);