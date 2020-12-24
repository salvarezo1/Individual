classdef Solutions < handle
    %SOLUTIONS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        % Reduces a matrix nxn by Gauss-Jordan method to a scalonade one.
        function reduct = Reductible(~, values)
            
            index = 1;
            
            for rows = 1:length(values(:,1))
                
                for thisrow = 1:length(values(:,1))
                    
                    if thisrow == index
                        continue;
                    end
                    
                    rowchange = values(thisrow, :);
                    
                    if values(rows, rows) == 0
                        continue;
                    else
                        
                        cons = sym(sym(rowchange(1, rows))/sym(values(rows, rows)));
                    
                    end
                    
                    for col = 1:length(rowchange)
                        
                        rowchange(col) = sym(sym(rowchange( : , col)) - sym(values(rows, col))*sym(cons));
                        
                    end
                    
                    values(thisrow, :) = sym(rowchange);
                end
                
                index = index + 1;
            end
            
            reduct = values;
        end
        
        % With the values of the scalonade matrix, generate a new array
        % with the solutions.
        function solutions = Results(~, values)
            
            result = (length(values(:,1)));
            
            for i = 1:length(values(:,1))
                result(i) = values(i, length(values))/values(i, i);
            end
            
            solutions = result;
        end
    end
end

