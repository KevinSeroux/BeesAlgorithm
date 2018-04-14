classdef Text < display.Base
    properties
        bestIndiv
    end
    
    methods
        % Executed after each iteration
        function print(~, ~)
        end
        
        % Executed after final iteration
        function finalPrint(~, pop)
            for i=1:length(pop)
                fprintf(pop(i).toString());
            end
        end
    end
end

