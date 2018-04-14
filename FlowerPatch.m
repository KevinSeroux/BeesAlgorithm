classdef FlowerPatch
    properties
        solution
        
        rank
        distance
        
        size
        stagnation
        stagnationCounter
    end
    
    methods
        function obj = FlowerPatch()
            obj.solution = Solution();
            obj.stagnationCounter = 0;
        end
    end
end

