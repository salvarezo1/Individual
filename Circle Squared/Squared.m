classdef Squared < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
%     properties
%         Property1
%     end
    
    methods
        function XYs = ValuesGenerator(~, radius, Mx, Ny)
            
            Mx = Mx + 1;
            Ny = Ny + 1;
            
            X_values = zeros(Mx, Ny);
            Y_values = zeros(Mx, Ny);
            S_values = zeros(Mx, Ny);
            
            Y_values(:, 1) = radius/sqrt(2);
            S_values(:, 1) = radius/sqrt(2);
            X_values(1, 1) = S_values(1,1);
            
            for S_0 = 2:Ny
               
                S_values(1, S_0) = 2*(sqrt(5*radius^2 - Y_values(1, S_0 - 1)^2) - 2*Y_values(1, S_0 - 1))/5;
                Y_values(1, S_0) = Y_values(1, S_0 - 1) + S_values(1, S_0);
                X_values(1, S_0) = S_values(1, S_0)/2;
                
            end
            
            for S_M = 2:Mx
                for S_N = 2:Ny
                    
                    S_values(S_M, S_N) = (sqrt(2*radius^2 - (X_values(S_M - 1, S_N) - Y_values(S_M, S_N - 1))^2) - (X_values(S_M - 1, S_N) + Y_values(S_M, S_N - 1)))/2;
                    Y_values(S_M, S_N) = Y_values(S_M, S_N - 1) + S_values(S_M, S_N);
                    X_values(S_M, S_N) = X_values(S_M - 1, S_N) + S_values(S_M, S_N);
                    
                end
            end
            
            surf(S_values);
            figure
            surf(Y_values);
            figure
            surf(X_values);
            
            XYs = S_values;
            
        end
    end
end

