classdef (Abstract) Base < handle
    methods (Abstract)
        print(population) % Executed after each iteration
        finalPrint(population) % Executed after final iteration
    end
end

