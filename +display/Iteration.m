classdef Iteration < display.Base
    properties
        curIt
    end
    
    methods
        function obj = Iteration()
            obj.curIt = 0;
        end
        
        % Executed after each iteration
        function print(obj, ~)
            obj.curIt = obj.curIt + 1;
            fprintf('%d ', obj.curIt);
        end
        
        % Executed after final iteration
        function finalPrint(~, pop)
            fprintf('\n');
            
            w = warning('off','MATLAB:structOnObject');
            disp(struct2table(arrayfun(@struct, pop)))
            warning(w);
        end
    end
end

