% Should stream for video from camera for about 10 seconds.
% If camera disconnected should display error message on EV3 screen.
% Uses camera.
% Tests camera_init, camera_takepic, camera_close.

port = 6789;
ip = '10.0.1.1';

% Initialize controller and the camera.
ctrl = ev3control(port, ip);
ctrl.camera_init();

% Take picture (non-normalized, values should be in range 0-255)
picture = ctrl.camera_takepic();

for m = 1:20
    % Take normalized pictures
    picture_norm = ctrl.camera_takepic('Normalize', 1);
    imshow(picture_norm);
    pause(0.5); % needed otherwise Matlab won't display
end

ctrl.camera_close();

ctrl.exit();
