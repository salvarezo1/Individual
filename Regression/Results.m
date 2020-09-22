classdef Results < handle
    %RESULTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        value
        solutions
        sum_data_p
        matrix_values
    end
    
    methods
        
        function obj = sum_data(obj, f_val, f_exp, s_val, s_exp)
            
            ret_val = 0;
            
            for i = 1:length(f_val)
                ret_val = ret_val + (f_val(i, 1)^f_exp)*(s_val(i, 1)^s_exp);
            end
            
            obj.sum_data_p = ret_val;
        end
        
        function obj = results(obj, values)
            
            result = (length(values(:,1)));
            
            for i = 1:length(values(:,1))
                result(i) = values(i, length(values))/values(i, i);
            end
            
            obj.solutions = result;
        end
        
        function obj = step(obj, values, index)
            
            for rows = 1:length(values(:,1))
                for thisrow = 1:length(values(:,1))
                    
                    if(thisrow == index)
                        continue;
                    end
                    
                    rowchange = values(thisrow, :);
                    
                    if(values(rows, rows) == 0)
                        continue;
                    else
                        cons = rowchange(1, rows)/values(rows, rows);
                    end
                    
                    for col = 1:length(rowchange)
                        car = rowchange( : , col) - values(rows, col)*cons;
                        rowchange(col) = car;
                    end
                    
                    values(thisrow, :) = rowchange;
                end
                
                index = index + 1;
            end
            
            obj.value = values;
        end
    end
    
    methods (Static)
        
        function genReg = generateValues()
            
            r1 = Results;
            rg1 = Regressions;
            
            rg1.tot = 15;
            rg1.originalFn();
            rg1.a_grade = 8;
            
            %rg1.orig = [0 1; 1 4; 2 9; 3 16; 4 25];
            
            matrices = zeros(rg1.a_grade + 1, rg1.a_grade + 2);
            
            for row = 1:size(matrices,1)
                for col = 1:size(matrices,2)
                    if(col ~= size(matrices,2))
                        r1.sum_data(rg1.orig(:, 1), row + col - 2, rg1.orig(:, 2), 0);
                    else
                        r1.sum_data(rg1.orig(:, 1), row - 1, rg1.orig(:, 2), 1);
                    end
                    matrices(row, col) = r1.sum_data_p;
                end
            end
            
            %disp(matrices);
            
            r1.step(matrices, 1);
            r1.results(r1.value);
            
            disp(r1.solutions);
            
            rg1.index(:, 1) = r1.solutions;
            rg1.polynomicReg(rg1.a_grade);
            rg1.expReg(0.0113619397114986, 0.681882418034206);
            disp(rg1.corr());
            rg1.to_plot();
            genReg = matrices;
        end
    end
end

