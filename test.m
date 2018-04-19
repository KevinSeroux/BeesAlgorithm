countTests = 100;
debugParetoFrontSize = 500;

[conf, paretoFront] = config.ZDT6(debugParetoFrontSize);
conf.display = {}; % Remove this to enable display
metric = Metric(paretoFront);
ba = BeesAlgorithm(conf);

convergences = [];
diversities = [];

% TODO : For 16.5 sec
for i=1:countTests
    %tic
    
    solutions = ba.run();
    convergence = metric.computeConvergence(solutions);
    diversity = metric.computeDiversity(solutions);
    
    convergences = [convergences, convergence];
    diversities = [diversities, diversity];
    save([conf.name, '.mat'], 'convergences', 'diversities');
    %fprintf("Convergence: %f, Diversity: %f\n", convergence, diversity);
    
    %disp(toc)
end
