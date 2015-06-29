classdef ev3control
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        port;
        ev3ip;
        client;
        WIDTH = 160;
        HEIGHT = 120;
        VALUES = 3;
        HEADER = 54;
    end
    
    methods
        function self = ev3control(port, ev3ip)
            self.port = port;
            self.ev3ip = ev3ip;
            self.client = tcpip(self.ev3ip, self.port, 'NetworkRole', 'client','InputBufferSize',100000);
        end
        
        % General/brick
        function beep(self)
            json_str = savejson('command', struct('cmd', 'beep', 'dev', 'brick'), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function buzz(self)
            json_str = savejson('command', struct('cmd', 'buzz', 'dev', 'brick'), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function exit(self)
            json_str = savejson('command', struct('cmd', 'exit', 'dev', 'brick'), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        % Motors
        function motor_init(self, where)
            json_str = savejson('command', struct('cmd', 'init', 'dev', 'motor', 'port', where), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function what = motor_forward(self, which)
            json_str = savejson('command', struct('cmd', 'forward', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function motor_backward(self, which)
            json_str = savejson('command', struct('cmd', 'backward', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function speed = motor_getspeed(self, which)
            json_str = savejson('command', struct('cmd', 'getspeed', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            speed = sprintf('%s', fread(self.client, 100));
            fclose(self.client);
        end
        
        function motor_stop(self, which)
            json_str = savejson('command', struct('cmd', 'stop', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        % Sensors
        function sensor_init(self, which, sensor_type)
            json_str = savejson('command', struct('cmd', 'init', 'dev', 'sensor', 'port', which, 'type', sensor_type), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function sensor_setmode(self, which, mode)
            json_str = savejson('command', struct('cmd', 'setmode', 'dev', 'sensor', 'port', which, 'mode', mode), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function mode = sensor_getmode(self, which)
            json_str = savejson('command', struct('cmd', 'getmode', 'dev', 'sensor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            mode = sprintf('%s', fread(self.client, 100));
            fclose(self.client);
        end
        
        function value = sensor_getvalue(self, which)
            json_str = savejson('command', struct('cmd', 'getvalue', 'dev', 'sensor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            value = sprintf('%s', fread(self.client, 100));
            fclose(self.client);
        end
        
        function sensor_close(self, which)
            json_str = savejson('command', struct('cmd', 'close', 'dev', 'sensor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        % Camera
        function camera_init(self, varargin)
            if nargin == 3
                self.WIDTH = varargin{1};
                self.HEIGHT = varargin{2};
            end
            json_str = savejson('command', struct('cmd', 'init', 'dev', 'camera', 'width', self.WIDTH, 'height', self.HEIGHT), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function pic = camera_takepic(self, varargin)
            ifnorm = 0;
            if nargin == 2
                ifnorm = strcmp(varargin{1}, 'norm');
            end
            
            % Brick sends back BMP image file with header and all
            bytes = self.HEADER + self.WIDTH * self.HEIGHT * self.VALUES;
            json_str = savejson('command', struct('cmd', 'takepic', 'dev', 'camera'), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            bmp_image = fread(self.client, bytes);
            fclose(self.client);
            
            % Extract image into MATLAB array
            pic = reshape(bmp_image(self.HEADER+1:end), [self.VALUES self.WIDTH self.HEIGHT]);
            pic = permute(pic, [2 3 1]);
            
            % Switch BGR into RGB
            b = pic(:,:,1);
            pic(:,:,1) = pic(:,:,3);
            pic(:,:,3) = b;
            
            % Rotate into standard position
            pic = rot90(pic);
            
            % Normalize
            if ifnorm
                pic = pic / 255.0;
            end
        end
    end
    
end