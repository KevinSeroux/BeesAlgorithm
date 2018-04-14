classdef POL_2 < objective.Base
    methods
        function obj = POL_2(args)
            % Invoke superclass constructor
            obj = obj@objective.Base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)
            assert(length(x) == 2);
            
            x1 = x(1);
            x2 = x(2);
            
            value = (x1 + 3)^2 + (x2 + 1)^2;
        end
    end
end

