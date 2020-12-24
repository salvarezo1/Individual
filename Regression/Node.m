classdef Node < handle
    
    properties
        data;
        prev;
        next;
        size = 0;
    end
    
    methods (Access = public)
        
        function self = Node(varargin)
            
            if nargin == 1
                self.data = varargin{1};
                self.size = 1;
                
            elseif nargin == 2
                self.data = varargin{1};
                self.next = varargin{2};
                varargin{2}.prev = self;
            end
                
        end
        
        function obj = setData(obj, data)
        
            obj.data = data;
            
        end
        
        function ret_val = getData(obj)
            
            ret_val = obj.data;
            
        end
        
        function obj = setNext(obj, next)
           
            obj.next = next;
            next.prev = obj;
            
        end
        
        function ret_val = getNext(obj)
            
            ret_val = obj.next;
            
        end
        
        function obj = setPrev(obj, prev)
        
            obj.prev = prev;
            prev.next = obj;
        
        end
        
        function ret_val = getPrev(obj)
            
            ret_val = obj.prev;
            
        end
    end
    
    methods (Access = private)
        
        function s_ze = Size(headNode)
        
            s_ze = 0;
            
            previousNodes = headNode;
            nextNodes = headNode;
            
            while isa(nextNodes, 'Node') || isa(previousNodes, 'Node')
                
                if isa(previousNodes, 'Node')
                    
                    previousNodes = previousNodes.prev;
                    s_ze = s_ze + 1;
                    
                end
                
                if isa(nextNodes, 'Node')
                
                    nextNodes = nextNodes.next;
                    s_ze = s_ze + 1;
                
                end
            end
        
        end
    end
end