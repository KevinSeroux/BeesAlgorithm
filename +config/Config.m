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
            obj.maxIteration = 205;
            obj.countScouts = 30;
            obj.countBestSites = 10;
            obj.countEliteSites = 6;
            obj.countBestSitesRecruits = 10;
            obj.countEliteSitesRecruits = 100;
            obj.patchShrinkingFactor = 0.95;
            obj.maxCountStagnation = 100;
            obj.display = {display.Iteration()};
            obj.variables = table([], [], 'VariableNames', {'min' 'max'});
        end
        
        function size = getPopSize(obj)
            nonSelectedBees = obj.countScouts - obj.countBestSites;
            bestNonEliteBeesAndRecruits = (obj.countBestSites - obj.countEliteSites) * ...
                obj.countBestSitesRecruits;
            eliteBeesAndRecruits = obj.countEliteSites * obj.countEliteSitesRecruits;
            
            size = nonSelectedBees + bestNonEliteBeesAndRecruits + eliteBeesAndRecruits;
        end
        
        function size = getInitialPatchSize(obj)
            exploreRange = max(obj.variables.max - obj.variables.min);
            countGlobalSearch = obj.countScouts - obj.countBestSites;
            size = exploreRange / countGlobalSearch;
        end
    end
end

