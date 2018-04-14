function solution = objectivesEvaluation(solution, objectives)
    countObjectives = length(objectives);
    solution.objectiveValues = nan(1, countObjectives);

    for i=1:countObjectives
        solution.objectiveValues(i) = ...
            objectives{i}.get(solution.variables);
    end
end