function field = generateEvaluatedParetoFront(variables, objectives)
    count = length(variables);
    field(count) = Solution();
    
    for i=1:count
        field(i).variables = variables(i,:);
        field(i) = evaluation.objectivesEvaluation(field(i), objectives);
    end
end
