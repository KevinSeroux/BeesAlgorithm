classdef KUR_2 < objective.Base
    methods
        function obj = KUR_2(args)
            % Invoke superclass constructor
            obj = obj@objective.Base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)
            assert(length(x) == 3);
            
            value = sum(abs(x)^0.8 + 5*sin(x)^3);
        end
    end
end

