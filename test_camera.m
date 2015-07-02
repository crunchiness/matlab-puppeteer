% Should stream for video from camera for about 10 seconds.
% If camera disconnected should display error message on EV3 screen.

port = 6789;
ip = '10.0.1.1';
ctrl = ev3control(port, ip);
ctrl.camera_init();
picture = ctrl.camera_takepic();
for m = 1:20
    picture_norm = ctrl.camera_takepic('norm');
    imshow(picture_norm);
    pause(0.5);
end
ctrl.camera_close();
ctrl.exit();