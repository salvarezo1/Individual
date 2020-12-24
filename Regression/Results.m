classdef Results < handle
    %RESULTS Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        
        %In charge of generate all the things necessary for the study of
        %the manipulation of regressions.
        
        function genReg = generateValues()
            
            rg1 = Regressions();
            
            rg1.Original_Function(100);
            
            %rg1.original_function = [0 1; 1 3; 2 9; 3 27];
            
            Grade = 99;
            
%            rg1.Polynomic_Regression(Grade);

%             for i = 1:100
%                 
%                 rg1.Polynomic_Regression(i);
%                 
%                 disp(i);
%                 disp(rg1.polynomic_regression{3});
%                 
%                 if rg1.Correlation(rg1.original_function, rg1.polynomic_regression{1}) > 95
%                     
%                     break
%                     
%                 end
%                 
%             end
            
            rg1.Polynomic_Regression(Grade);
            rg1.Exponential_Regression();
            
            rg1.Plot_Regressions();
            
            disp('Polynomic');
            rg1.Correlation(rg1.original_function, rg1.polynomic_regression{1});
            disp('Exponential');
            rg1.Correlation(rg1.original_function, rg1.exponential_regression{1});
            
            genReg = rg1;
        end
    end
end

