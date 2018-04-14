classdef SCH_2 < objective.Base    
    methods
        function obj = SCH_2(args)
            % Invoke superclass constructor
            obj = obj@objective.Base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)            
            value = (x-2)^2;
        end
    end
end

