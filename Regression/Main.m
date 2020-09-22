classdef Main < handle
    %MAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods (Static)
        function mn = main()
            reg = Regressions;
            reg.tot = 15;
            reg.originalFn();
            reg.index = [7.6020188338; -22.198989095; 9.6523486495; -1.3435805648; 0.059312857228];
            reg.a_grade = 4;
            reg.polynomicReg(4);
            reg.expReg(0.0113619397114986, 0.681882418034206);
            reg.corr();
            %C = [reg.orig reg.polyn reg.expo];
            %disp(C);
            reg.to_plot();
%             pr = Regressions;
%             pr.tot = 15;
%             pr.index = [1; log(2); log(2)^2; log(2)^3; log(2)^4]/100;
%             pr.a_grade = 4;
%             pr.polynomicReg(4);
%             figure
%             hold on
%             plot(reg.polyn(:,1), reg.polyn(:,2), 'b', 'LineWidth',2);
%             plot(pr.polyn(:,1), pr.polyn(:,2), 'r', 'LineWidth',2);
            mn = reg.rec;
        end
    end
end

