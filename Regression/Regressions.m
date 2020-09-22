classdef Regressions < handle
    %REGRESSIONS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tot
        orig
        polyn
        a_grade
        index
        expo
        rec
        less_data_orig
    end
    
    %properties (Dependent)
     %   less_data_orig
    %end
    
    methods 
        
        function obj = originalFn(obj, ~)
            
            retorn = zeros(10*obj.tot+1, 2);
            
            for t = 0:10*obj.tot
                k = t/10;
                
                y = exp(log(2)*k);
                
                if mod(y,10) < 5
                    y = floor(y/10)/10;
                else
                    y = ceil(y/10)/10;
                end
                
                retorn(t+1, 1) = k;
                retorn(t+1, 2) = y;
            end
            
            obj.orig = retorn;
            %disp(obj.orig);
            
            %plot(retorn(:,1), retorn(:,2), '-.b', 'LineWidth',2);
        end
        
        function obj = polynomicReg(obj, abs_grade)
            
            close(figure);
            
            table = zeros(10*obj.tot + 1, 2);
            
            if isempty(obj.index) || obj.a_grade ~= abs_grade
                
                obj.a_grade = abs_grade;
                indices = zeros(abs_grade+1, 1);

                for ind = 0:abs_grade
                    k = num2str(ind);
                    indices(ind+1, 1) = input(sprintf('Index number %s: ', k));
                end
                
                obj.index = indices;
            end
            
            for t = 0:10*obj.tot
                i = t/10;
                add_up = 0;
                table(t+1 , 1) = i;
                
                for grade = 0:abs_grade
                    add_up = add_up + obj.index(grade+1, 1)*i^grade;
                end
                
                table(t+1, 2) = add_up;
            end
            
            distabl = zeros(obj.tot+1, 2);
            
            for l = 0:obj.tot
                distabl(l+1, 1) = table(10*l + 1, 1);
                distabl(l+1, 2) = table(10*l + 1, 2);
            end
            
            %disp(distabl);
            
            obj.polyn = table;
            
            %plot(table(:,1), table(:,2), '--r', 'LineWidth', 2);
        end
        
        function obj = expReg(obj, a, k)
            
            table = zeros(10*obj.tot + 1, 2);
            
            for i = 0:10*obj.tot
                l = i/10;
                table(i + 1, 1) = l;
                table(i + 1, 2) = a*exp(k*l);
            end
            
            %disp(distabl);
            
            obj.expo = table;
            
            %figure;
            %plot(table(:,1), table(:,2), '--g', 'LineWidth', 2);
        end
        
        function obj = corr(obj)
            
            rege = zeros(2,1);
            y_prom = 0;
            
            for prom = 0:obj.tot
                y_prom = y_prom + obj.orig(10*prom+1, 2);
            end
            y_prom = y_prom/obj.tot;
            
            ss_tot = 0;
            ss_res_e = 0;
            ss_res_p = 0;
            
            for reg = 0:obj.tot
                ss_tot = ss_tot + (obj.orig(10*reg+1, 2) - y_prom)^2;
                ss_res_e = ss_res_e + (obj.orig(10*reg+1, 2) - obj.expo(10*reg+1, 2))^2;
                ss_res_p = ss_res_p + (obj.orig(10*reg+1, 2) - obj.polyn(10*reg+1, 2))^2;
            end
            
            reg_e = 1 - ss_res_e/ss_tot;
            reg_p = 1 - ss_res_p/ss_tot;
            
            rege(1,1) = reg_p;
            rege(2,1) = reg_e;
            
            obj.rec = rege;
            disp(rege);
        end
        
        function obj = less_orig(obj, fn)
            
            distabl = zeros(obj.tot + 1, 2);
            
            for l = 0:obj.tot
                
                distabl(l+1, 1) = fn(10*l + 1, 1);
                distabl(l+1, 2) = fn(10*l + 1, 2);
            end
            
            obj.less_data_orig = distabl;
        end
        
        function obj = to_plot(obj)
            figure
            
            obj.less_orig(obj.orig);
            
            hold on
            plot(obj.less_data_orig(:,1), obj.less_data_orig(:,2), '*k', 'LineWidth', 2.5)
            plot(obj.orig(:,1), obj.orig(:,2), '-.k', 'LineWidth', 2.5)
            plot(obj.polyn(:,1), obj.polyn(:,2), 'b', 'LineWidth', 1.5)
            plot(obj.expo(:,1), obj.expo(:,2), 'r', 'LineWidth', 1.5)
        end
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