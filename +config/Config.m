classdef Config < handle  
    properties        
        % Optional
        maxIteration
        name
        
        % count elite sites <= count best sites <= count scouts
        countScouts % Count of bees performing global search
        countBestSites % Count of bees recruiting countbestSitesRecruits bees
        countEliteSites % Count of bees recruiting countEliteSitesRecruits bees
        countBestSitesRecruits
        countEliteSitesRecruits
        patchShrinkingFactor
        maxCountStagnation
        
        display
        
        % Mandatory to be filled by user
        variables
        objectives
    end
    
    methods
        function obj = Config()
            obj.maxIteration = 100;
            obj.countScouts = 50;
            obj.countBestSites = 8;
            obj.countEliteSites = 3;
            obj.countBestSitesRecruits = 3;
            obj.countEliteSitesRecruits = 5;
            obj.patchShrinkingFactor = 0.8;
            obj.maxCountStagnation = 7;
            obj.display = {display.Iteration()};
            obj.variables = table([], [], 'VariableNames', {'min' 'max'});
        end
        
        function size = getInitialPatchSize(obj)
            exploreRange = max(obj.variables.max - obj.variables.min);
            countGlobalSearch = obj.countScouts - obj.countBestSites;
            size = exploreRange / countGlobalSearch;
        end
    end
end

