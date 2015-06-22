classdef ev3control
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        port;
        ev3ip;
        client;
    end
    
    methods
        function self = ev3control(port, ev3ip)
            self.port = port;
            self.ev3ip = ev3ip;
            self.client = tcpip(self.ev3ip, self.port, 'NetworkRole', 'client');
        end
        
        function beep(self)
            json_str = savejson('command', struct('cmd', 'beep'), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function buzz(self)
            fopen(self.client);
            fwrite(self.client, 'No');
            fclose(self.client);
        end
        
        function motor(self, which, degrees)
            json_str = savejson('command', struct('cmd', 'motor', 'which', which, 'degrees', degrees), 'Compact', 1);
            fopen(self.client);
            fwrite(self.client, json_str);
            fclose(self.client);
        end
        
        function exit(self)
            fopen(self.client);
            fwrite(self.client, 'Exit');
            fclose(self.client);
        end
    end
    
end

