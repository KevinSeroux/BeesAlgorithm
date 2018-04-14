countTests = 1;
debugParetoFrontSize = 500;

[conf, paretoFront] = config.FON(debugParetoFrontSize);
metric = Metric(paretoFront);
ba = BeesAlgorithm(conf);

convergences = [];
diversities = [];

for i=1:countTests
    solutions = ba.run();
    convergence = metric.computeConvergence(solutions);
    diversity = metric.computeDiversity(solutions);
    
    convergences = [convergences, convergence];
    diversities = [diversities, diversity];
    save([conf.name, '.mat'], 'convergences', 'diversities');
    fprintf("Convergence: %f, Diversity: %f\n", convergence, diversity);
end
