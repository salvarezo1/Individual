classdef Regressions < handle
    %REGRESSIONS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %original_function: Function made for the first part of the article.
        original_function
        %polynomic_regression: Function made for create a polynomic regression.
        polynomic_regression
        %exponential_regression: Saves the data to plot the exponential
        %regression.
        exponential_regression
        %polynomic_exponential_correlation: Saves the correlation between
        %the orginal function and the polynomic and exponential
        %regressions.
        polynomic_exponential_correlation
    end
    
    methods 
        
        function obj = Original_Function(obj, amount_dates)
            
            %Creates the function that I'm trying to study, whose formula
            %is in the article.
            
            retorn = zeros(amount_dates, 2);
            
            for t = 1:amount_dates
                
                y = exp(log(2)*t);
                
                if mod(y,10) < 5
                    y = floor(y/10)/10;
                else
                    y = ceil(y/10)/10;
                end
                
                retorn(t, 1) = t;
                retorn(t, 2) = y;
            end
            
            obj.original_function = retorn;
            
        end
        
        %Auxiliar
        function end_data = Sum_Data_Polynomic_Regression(~, varargin)
            
            ret_val = 0;
            
            if length(varargin) == 2
                
                for i = 1:length(varargin{1})
                    
                    ret_val = ret_val + varargin{1}(i, 1)^varargin{2};
                end
                
            elseif length(varargin) == 4
                    
                for i = 1:length(varargin{1})
                    
                    ret_val = ret_val + (varargin{1}(i, 1)^varargin{2})*(varargin{3}(i, 1)^varargin{4});
                end
                
            end
                    
            end_data = ret_val;
            %disp(end_data);

        end
        
        %Auxiliar
        function matrix_of_values = Generate_Values(obj, Grade, Function)
            
            %r1 = Regressions();
            matrix_of_values_return = zeros(Grade + 1, Grade + 2);
        
            for row = 1:size(matrix_of_values_return,1)
                
                for column = 1:size(matrix_of_values_return,2)
                    
                    if(column ~= size(matrix_of_values_return,2))
                        
                        matrix_of_values_return(row, column) = obj.Sum_Data_Polynomic_Regression(Function(:, 1), row + column - 2);
                    
                    else
                        
                        matrix_of_values_return(row, column) = obj.Sum_Data_Polynomic_Regression(Function(:, 1), row - 1, Function(:, 2), 1);
                    
                    end
                end
            end
            
            matrix_of_values = matrix_of_values_return;
            
        end
        
        %Auxiliar
        function indices = Generate_Polynomic_Indices(obj, Grade, Function)
            
            s1 = Solutions();
            
            matrix = obj.Generate_Values(Grade, Function);
            reduct_matrix = s1.Reductible(matrix);
            indices = s1.Results(reduct_matrix);
            
        end
        
        function obj = Polynomic_Regression(obj, varargin)
            
            %Generates a polynomic regression of an "abs_grade", which is
            %its maximum.
            %varargin{1}: Grade.
            %varargin{2}: Function. If this doesn't exist, then it will be
            %taken the attribute obj.original_function.
            
            Grade = varargin{1};
            
            if length(varargin) == 1
                
                Function = obj.original_function;
                
            elseif length(varargin) == 2
                
                Function = varargin{2};
                
            end
            
            polynomic_table = zeros(length(Function), 2);
            Indices = obj.Generate_Polynomic_Indices(Grade, Function);
            
            min_el = 1;
            max_el = min_el;
            
            for t = 1:length(Function)
                
                add_up = 0;
                polynomic_table(t , 1) = Function(t, 1);
                
                if polynomic_table(t , 1) > polynomic_table(max_el , 1)
                    
                    max_el = t;
                    
                elseif polynomic_table(t , 1) < polynomic_table(min_el , 1)
                    
                    min_el = t;
                    
                end
                
                for grade = 0:Grade
                    add_up = add_up + Indices(grade+1)*polynomic_table(t , 1)^grade;
                end
                
                polynomic_table(t , 2) = add_up;
            end
            
            
            if length(polynomic_table) < 100
                
                plot_polynomic_function = zeros(101, 2);
                
                for i = 0:100
                    
                    add_up = 0;
                    plot_polynomic_function(i + 1, 1) = polynomic_table(min_el, 1) + i*(polynomic_table(max_el, 1) - polynomic_table(min_el, 1))/100;
                    
                    for grade = 0:Grade
                        add_up = add_up + Indices(grade + 1)*plot_polynomic_function(i + 1, 1)^grade;
                    end
                    
                    plot_polynomic_function(i + 1, 2) = add_up;
                end
                
            else
                
                plot_polynomic_function = polynomic_table;
                
            end
            
            obj.polynomic_regression{1} = polynomic_table;
            obj.polynomic_regression{2} = plot_polynomic_function;
            obj.polynomic_regression{3} = Indices;

            %disp(distabl);
            %plot(distabl(:,1), distabl(:,2));
            %plot(table(:,1), table(:,2), '--r', 'LineWidth', 2);
            
        end
        
        function obj = Exponential_Regression(obj, varargin)
            
            %Generates an exponential regression having a base (a in the
            %article) and an exponent (k in the article). Don't know how to
            %make it to exponent and base differents. Maybe a boolean
            %variable?
            
            if length(varargin) >= 2
                
                constant = varargin{1};
                exponent = varargin{2};
                
                if length(varargin) == 2
                    
                    Function = obj.original_function;
                    
                else
                    
                    Function = varargin{3};
                    
                end
                
            elseif length(varargin) <= 1
                
                if isempty(varargin)
                
                    Function = obj.original_function;
                    
                elseif length(varargin) == 1
                    
                    Function = varargin{1};
                    
                end
                
                Zeros1 = LinkedList();
                
                for t = 1:length(Function)
                    
                    if round(Function(t, 2), 1) >= 1
                        
                        Zeros1.insertAtEnd(Node(Function(t, :)));
                        
                    end
                end
                
                Function1 = zeros(Zeros1.size, 2);
                
                head1 = Zeros1.head;
                
                for i = 1:Zeros1.size
                   
                    Function1(i, :) = head1.data;
                    head1 = head1.next;
                    
                end
                
                Function1(:, 2) = log(Function1(:, 2));
                
                r1 = Regressions();
                
                r1.Polynomic_Regression(1, Function1);
                
                indices = r1.polynomic_regression{3};
                
                constant = exp(indices(1));
                exponent = indices(2);
                disp(constant);
                disp(exponent);
                
            end
                
            indices = [constant exponent];
            
            exponential_table = zeros(length(Function), 2);
            
            min_el = 1;
            max_el = min_el;
            
            for i = 1:length(Function)

                exponential_table(i, :) = [Function(i, 1) constant*exp(exponent*Function(i, 1))];
                
                if exponential_table(min_el, 1) > exponential_table(i, 1)
                   
                    min_el = i;
                    
                elseif exponential_table(max_el, 1) < exponential_table(i, 1)
                    
                    max_el = i;
                    
                end
            end
            
            if length(exponential_table) < 100
               
                plot_exponential_function = zeros(101, 2);
                
                for i = 0:100
                   
                    plot_exponential_function(i+1, 1) = exponential_table(min_el, 1) + i*(exponential_table(max_el, 1) - exponential_table(min_el, 1))/100;
                    
                    plot_exponential_function(i+1, 2) = constant*exp(exponent*plot_exponential_function(i+1, 1));
                    
                end
                
            else
                
                plot_exponential_function = exponential_table;
            end
            
            obj.exponential_regression{1} = exponential_table;
            obj.exponential_regression{2} = plot_exponential_function;
            obj.exponential_regression{3} = indices;
        end
        
        function correlation = Correlation(~, original_function, regressive_function)
            
            %Returns the correlation of the polynomic and exponential
            %regression with respect to the original function.
            
            y_prom = 0;
            amount_of_dates = length(original_function);
            
            for prom = 1:amount_of_dates
                
                y_prom = y_prom + original_function(prom, 2);
                
            end
            
            y_prom = y_prom/amount_of_dates;
            
            ss_tot = 0;
            ss_regressive = 0;
            
            for reg = 1:amount_of_dates
                ss_tot = ss_tot + (original_function(reg, 2) - y_prom)^2;
                ss_regressive = ss_regressive + (original_function(reg, 2) - regressive_function(reg, 2))^2;
            end
            
            digits(8)
            correlation = vpa(1 - ss_regressive/ss_tot);
            
            disp(correlation);
        end
        
        function obj = Less_Data_Original_Function(obj, original_function)
            
            %Generates with some data of the original function another one
            %which doesn't support too much values, so it's perfect to
            %generate points in the plot (in this case I'm using
            %asterisks).
            
            dates_to_return = zeros(obj.amount_dates + 1, 2);
            
            for l = 0:obj.amount_dates
                
                dates_to_return(l+1, 1) = original_function(10*l + 1, 1);
                dates_to_return(l+1, 2) = original_function(10*l + 1, 2);
            end
            
            obj.less_data_original_function = dates_to_return;
        end
        
        function obj = Plot_Regressions(obj)
            
            %Used to plot the regressions (must exist both the polynomic
            %and exponential regressions) and compare them graphically with
            %the original function. The main idea is to expand this project
            %to generate whichever original function I wish and generate
            %the best option to the exponential regression.
            
            figure
            
%             obj.Less_Data_Original_Function(obj.original_function);
            
            hold on
            
%             plot(obj.less_data_original_function(:,1), obj.less_data_original_function(:,2), 'ko', 'LineWidth', 2.5)
            
            plot(obj.original_function(:,1), obj.original_function(:,2), 'ko', 'LineWidth', 2.5)
            
            if ~isempty(obj.polynomic_regression) && ~isempty(obj.polynomic_regression{2})
                table_polynomic = obj.polynomic_regression{2};
                plot(table_polynomic(:,1), table_polynomic(:,2), 'b', 'LineWidth', 1.5)
                
            end
            
            if ~isempty(obj.exponential_regression) && ~isempty(obj.exponential_regression{2})
                table_exponential = obj.exponential_regression{2};
                plot(table_exponential(:,1), table_exponential(:,2), 'r', 'LineWidth', 1.5)
            end
            
        end
        
    end
    
end