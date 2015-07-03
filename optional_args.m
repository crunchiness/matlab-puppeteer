function params = optional_args( params, args )
% Takes as input struct with default parameters
% Returns with the parsed ones (args = varargin)
    for i=1:(size(args,2)/2)
        param_name = args{i*2-1};
        param_value = args{i*2};
        params.(param_name) = param_value;
    end
end