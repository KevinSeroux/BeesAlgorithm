classdef BeesAlgorithm
    properties
        config
    end
    
    methods
        function obj = BeesAlgorithm(config)
            obj.config = config;
        end
        
        function eliteSolutions = run(obj)
            countScouts = obj.config.countScouts;
            countNonBestScouts = countScouts - obj.config.countBestSites;
            
            scouts = obj.globalSearch(countScouts);
            for iteration=1:obj.config.maxIteration
                obj.print(scouts);
                
                [elite, justBest] = obj.waggleDance(scouts);
                
                elite = obj.exploit(elite, obj.config.countEliteSitesRecruits);
                justBest = obj.exploit(justBest, obj.config.countBestSitesRecruits);
                others = obj.globalSearch(countNonBestScouts);
                
                scouts = [elite, justBest, others];
            end
            
            elite = obj.waggleDance(scouts);
            eliteSolutions = [elite.solution];
            obj.finalPrint(eliteSolutions);
        end
        
        function scouts = globalSearch(obj, countScouts)
            scouts(countScouts) = FlowerPatch();
            
            for i=1:countScouts
                scouts(i) = obj.searchFlowerPatch();
            end
        end
        
        function scout = searchFlowerPatch(obj)
            vars = obj.config.variables;
            countVariables = height(vars);
            mins = vars.min;
            maxs = vars.max;
            
            scout = FlowerPatch();
            scout.size = obj.config.getInitialPatchSize();
            scout.solution.variables = nan(1, countVariables);
            
            for i=1:countVariables                
                scout.solution.variables(i) = utils.randBetween(mins(i), maxs(i));
            end
            
            scout.solution = evaluation.objectivesEvaluation(scout.solution, obj.config.objectives);
        end
        
        function [elite, best] = waggleDance(obj, scouts)
            sortedBees = obj.gatherBestSortedBees(scouts);
            
            elite = sortedBees(1:obj.config.countEliteSites);
            best = sortedBees(obj.config.countEliteSites+1:end);
        end
        
        function sortedBees = gatherBestSortedBees(obj, bees)
            countBestSites = obj.config.countBestSites;
            fronts = evaluation.fastNonDeterminatedSort(bees); % TODO: Limit count front
            sortedBees = [];
            curFrontIdx = 1;
            
            while length(sortedBees) + length(fronts{curFrontIdx}) <= countBestSites
                sortedBees = [sortedBees, fronts{curFrontIdx}];
                curFrontIdx = curFrontIdx + 1;
            end
            
            remainingBees2Add = countBestSites - length(sortedBees);
            if remainingBees2Add > 0
                lastFront = evaluation.crowdingDistanceAssignment( ...
                    fronts{curFrontIdx}, obj.config.objectives ...
                );
                sortedLastFront = utils.sortfun( ...
                    @(flower) flower.distance, lastFront, 'DESCEND' ...
                );
                sortedBees = [sortedBees, sortedLastFront(1:remainingBees2Add)];
            end
        end
        
        function scouts = exploit(obj, scouts, countRecruitedBees)
            for i=1:length(scouts)
                scoutBee = scouts(i);
                
                scoutBee = obj.localSearch(scoutBee, countRecruitedBees);
                if scoutBee.stagnation
                    scoutBee = obj.neighbourhoodShrinking(scoutBee);
                    scoutBee = obj.siteAbandonment(scoutBee);
                end
                
                scouts(i) = scoutBee;
            end
        end
        
        function bestScoutBee = localSearch(obj, scoutBee, countRecruitedBees)
            scoutBee.stagnation = true;
            size = scoutBee.size;
            vars = scoutBee.solution.variables;
            countVars = height(obj.config.variables);
            min = vars - size;
            max = vars + size;

            someRandomValues = min + (max - min) .* ...
                rand(countRecruitedBees, countVars);
            
            bestScoutBee = scoutBee;
            for i=1:countRecruitedBees
                bee = Solution();
                bee.variables = someRandomValues(i,:);
                
                bee = evaluation.objectivesEvaluation(bee, obj.config.objectives);
                if evaluation.paretoDominates(bee, scoutBee.solution)
                    bestScoutBee.solution = bee;
                    bestScoutBee.stagnation = false;
                end
            end
        end
        
        function scoutBee = neighbourhoodShrinking(obj, scoutBee)
            scoutBee.size = obj.config.patchShrinkingFactor * scoutBee.size;
        end
        
        function scoutBee = siteAbandonment(obj, scoutBee)
            if scoutBee.stagnationCounter < obj.config.maxCountStagnation
                scoutBee.stagnationCounter = scoutBee.stagnationCounter + 1;
            else
                scoutBee = obj.searchFlowerPatch();
            end
        end
        
        function print(obj, scouts)
            displays = obj.config.display;
            for i=1:length(displays)
                displays{i}.print(scouts);
            end
        end
        
        function finalPrint(obj, scouts)
            displays = obj.config.display;
            for i=1:length(displays)
                displays{i}.finalPrint(scouts);
            end
        end
    end
end

