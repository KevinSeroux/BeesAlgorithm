classdef SCH_1 < objective.Base
    methods
        function obj = SCH_1(args)
            % Invoke superclass constructor
            obj = obj@objective.Base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)            
            value = x^2;
        end
    end
end

