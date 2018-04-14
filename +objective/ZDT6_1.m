classdef ZDT6_1 < objective.Base
    methods
        function obj = ZDT6_1(args)
            % Invoke superclass constructor
            obj = obj@objective.Base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)
            x1 = x(1);
            
            value = 1 - exp(-4*x1)*sin(6*pi*x1)^6;
        end
    end
end

