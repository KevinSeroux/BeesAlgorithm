classdef ZDT1_1 < objective.Base
    methods
        function obj = ZDT1_1(args)
            % Invoke superclass constructor
            obj = obj@objective.Base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)          
            value = x(1);
        end
    end
end

