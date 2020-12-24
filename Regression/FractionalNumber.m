classdef FractionalNumber < handle
    %FRACTIONALnumeratorBER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        numerator;
        denominator;
    end
    
    methods (Access = public)
        
        function self = FractionalNumber(varargin)
        
            if nargin == 0
                self.denominator = 1;
                self.numerator = 1;
                
            elseif nargin == 2
                    
                self.numerator = varargin{1};
                if varargin{2} == 0
                    self.denominator = realmin;
                else
                    self.denominator = varargin{2};
                end
                
            else
                self.numerator = varargin{1};
                self.denominator = 1;
            end
        end
        
    end
    
    methods
        
        %Obtener el numeratorerador del número fraccionario
        function newFr = get_Numerator(obj)
            newFr = obj.numerator;
        end
        
        %Obtener el denominatorominador del número fraccionario
        function newFr = get_Denominator(obj)
            newFr = obj.denominator;
        end
        
        %Pasar un número fraccionario a double.
        function doubVal = getFractionAsDouble(obj)
            doubVal = obj.numerator/obj.denominator;
        end
        
        %Sumar dos números fraccionarios.
        function result = Sum(obj, obj1, obj2)
            obj.numerator = obj1.numerator*obj2.denominator + obj1.denominator*obj2.numerator;
            obj.denominator = obj1.denominatorobj2.denominator;
            result = obj;
        end
        
        %Restar dos números fraccionarios.
        function result = Substract(obj, obj1, obj2)
            obj.numerator = obj1.numerator*obj2.denominator - obj1.denominator*obj2.numerator;
            obj.denominator = obj1.denominator*obj2.denominator;
            result = obj;
        end
        
        %Multiplicar dos números fraccionarios.
        function result = Multiplication(obj, obj1, obj2)
            obj.numerator = obj1.numerator*obj2.numerator;
            obj.denominator = obj1.denominator*obj2.denominator;
            result = obj;
        end
        
        %Dividir dos números fraccionarios.
        function result = Division(obj, obj1, obj2)
            obj.numerator = obj1.numerator*obj2.denominator;
            obj.denominator = obj1.denominator*obj2.numerator;
            result = obj;
        end
        
    end
    
end

