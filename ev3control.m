classdef ev3control < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    % Brick commands:
    % BEEP, BUZZ, EXIT
    
    % Motor commands:
    % INIT, CLOSE, FORWARD, BACKWARD, STOP, GETTACHO, RESETTACHO, GETSPEED,
    % SETSPEED, ROTATE
    
    % Sensor commands:
    % INIT, CLOSE, GETVALUE, SETMODE, GETMODE
    
    % Camera commands:
    % INIT, CLOSE, TAKEPIC

    properties
        port;
        ev3ip;
        client;
        WIDTH;
        HEIGHT;
        VALUES = 3;
        HEADER = 54;
    end
    
    methods
        function self = ev3control(port, ev3ip)
            self.port = port;
            self.ev3ip = ev3ip;
            self.client = tcpip(self.ev3ip, self.port, 'NetworkRole', 'client','InputBufferSize', 100000, 'Timeout', 120);
        end
        
        
        % General/brick %
        %%%%%%%%%%%%%%%%%
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
        
        % Motors %%%%%%%%
        %%%%%%%%%%%%%%%%%
        function motor_init(self, where, type)
            % type: medium, large
            % port: A, B, C, D
            json_str = savejson('command', struct('cmd', 'init', 'dev', 'motor', 'port', where, 'motor_type', type), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function motor_close(self, which)
            json_str = savejson('command', struct('cmd', 'close', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function motor_forward(self, which)
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
        
        function motor_stop(self, which)
            json_str = savejson('command', struct('cmd', 'stop', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function reading = motor_gettacho(self, which)
            json_str = savejson('command', struct('cmd', 'gettacho', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            valueJSON = loadjson(sprintf('%s', fread(self.client, 100)));
            reading = valueJSON.tacho;
            fclose(self.client);
        end
        
        function motor_resettacho(self, which)
            json_str = savejson('command', struct('cmd', 'resettacho', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function reading = motor_getspeed(self, which)
            json_str = savejson('command', struct('cmd', 'getspeed', 'dev', 'motor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            valueJSON = loadjson(sprintf('%s', fread(self.client, 100)));
            reading = valueJSON.speed;
            fclose(self.client);
        end
        
        function motor_setspeed(self, which, speed)
            json_str = savejson('command', struct('cmd', 'setspeed', 'dev', 'motor', 'port', which, 'speed', speed), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function motor_rotate(self, which, degrees, varargin)
            defaults = struct('IsAsync', 1);
            params = optional_args(defaults, varargin);
            
            json_str = savejson('command', struct('cmd', 'rotate', 'dev', 'motor', 'port', which, 'rotate_deg', degrees, 'is_async', params.('IsAsync')), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            if ~params.('IsAsync')
                fread(self.client, 100);
            end
            fclose(self.client);
        end
        
        function macro_turn(self, motor_port1, motor_port2, degrees, varargin)
            % turns the robot in place by some angle, using two wheels
            % can be blocking or asynchronous (default)
            defaults = struct('WheelDistance', 20.5, 'WheelRadius', 1.75, 'IsAsync', 1);
            params = optional_args(defaults, varargin);
            
            angle1 = round(((degrees*params.('WheelDistance')) / (params.('WheelRadius')*2)));
            angle2 = -angle1;
            self.motor_rotate(motor_port1, angle1);
            self.motor_rotate(motor_port2, angle2, 'IsAsync', params.('IsAsync'));
            % If not async, make sure that the asynchronous wheel is
            % stopped, otherwise it could receive the next command a before
            % it's finished.
            if ~params.('IsAsync')
                self.motor_stop(motor_port1);
            end
        end
        
        function macro_rotate(self, motor_port1, motor_port2, degrees, varargin)
            defaults = struct('IsAsync', 1);
            params = optional_args(defaults, varargin);
            self.motor_rotate(motor_port1, degrees);
            self.motor_rotate(motor_port2, degrees, 'IsAsync', params.('IsAsync'));
            if ~params.('IsAsync')
                self.motor_stop(motor_port1);
            end
        end
        
        function macro_forward(self, motor_port1, motor_port2)
            self.motor_forward(motor_port1);
            self.motor_forward(motor_port2);
        end
        
        function macro_backward(self, motor_port1, motor_port2)
            self.motor_backward(motor_port1);
            self.motor_backward(motor_port2);
        end
        
        function macro_stop(self, motor_port1, motor_port2)
            self.motor_stop(motor_port1);
            self.motor_stop(motor_port2);
        end
        
        % Sensors %%%%%%%
        %%%%%%%%%%%%%%%%%
        function sensor_init(self, which, sensor_type)
            json_str = savejson('command', struct('cmd', 'init', 'dev', 'sensor', 'port', which, 'sensor_type', sensor_type), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function sensor_close(self, which)
            json_str = savejson('command', struct('cmd', 'close', 'dev', 'sensor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function value = sensor_getvalue(self, which)
            json_str = savejson('command', struct('cmd', 'getvalue', 'dev', 'sensor', 'port', which), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            valueJSON = loadjson(sprintf('%s', fread(self.client, 100)));
            value = valueJSON.value;
            if iscell(value)
                value = inf;
            end
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
            modeJSON = loadjson(sprintf('%s', fread(self.client, 100)));
            mode = modeJSON.mode;
            fclose(self.client);
        end

        function colorid = color_id_to_str(~, id)
            %[BLACK, BLUE, BROWN, CYAN, DARK_GRAY, GRAY, GREEN, LIGHT_GRAY,MAGENTA, NONE, ORANGE, PINK, RED, WHITE, YELLOW]
            %[7,     2,    13,    12,   11         9,    1,     10,         4,      -1,   5,      8,    0,   6,     3]
            switch id
                case 7
                    colorid = 'BLACK';
                case 2
                    colorid = 'BLUE';
                case 13
                    colorid = 'BROWN';
                case 12
                    colorid = 'CYAN';
                case 11
                    colorid = 'DARK_GRAY';
                case 9
                    colorid = 'GRAY';
                case 1
                    colorid = 'GREEN';
                case 10
                    colorid = 'LIGHT_GRAY';
                case 4
                    colorid = 'MAGENTA';
                case -1
                    colorid = 'NONE';
                case 5
                    colorid = 'ORANGE';
                case 8
                    colorid = 'PINK';
                case 0
                    colorid = 'RED';
                case 6
                    colorid = 'WHITE';
                case 3
                    colorid = 'YELLOW';
                otherwise
                    colorid = 'UNKNOWN';
            end
        end
        % Camera %%%%%%%%
        %%%%%%%%%%%%%%%%%
        function self = camera_init(self, varargin)
            defaults = struct('Width', 176, 'Height', 144);
            params = optional_args(defaults, varargin);
            self.WIDTH = params.('Width');
            self.HEIGHT = params.('Height');
            json_str = savejson('command', struct('cmd', 'init', 'dev', 'camera', 'cam_width', self.WIDTH, 'cam_height', self.HEIGHT), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function camera_close(self)
            json_str = savejson('command', struct('cmd', 'close', 'dev', 'camera'), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function pic = camera_takepic(self, varargin)
            
            defaults = struct('Normalize', 0);
            params = optional_args(defaults, varargin);
            
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
            if params.('Normalize')
                pic = pic / 255.0;
            end
        end
    end
    
end