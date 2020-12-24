classdef LinkedList < handle
    
    properties
        
        head;
        tail;
        size;
        
    end
    
    methods (Access = public)
    
        function self = LinkedList()
        
            self.size = 0;
            
        end
        
    end
    
    methods
        
        function obj = clearList(obj)
            
            obj.head = single.empty;
            obj.tail = obj.head;
            obj.size = 0;
            
        end
    
        function getter = getHead(obj)
        
            getter = obj.head;
            
        end
        
        function getter = getTail(obj)
            
            getter = obj.tail;
            
        end
        
        function getter = Size(obj)
            
            getter = obj.size;
            
        end
        
        function obj = insertAtBegin(obj, node)
            
            node.next = obj.head;
            obj.head = node;
            
            if obj.size > 0
            
                node.next.prev = node;
                
            else
                
                obj.tail = node;
                
            end
            
            obj.size = obj.size + 1;
            
        end
        
        function obj = insertAtEnd(obj, node)
            
            node.prev = obj.tail;
            obj.tail = node;
            
            if obj.size > 0
                
                node.prev.next = node;
                
            else
                
                obj.head = node;
                
            end
            
            obj.size = obj.size + 1;
        
        end
        
        function obj = insert(obj, node, index)
            
            if index <= 0 || ~isa(obj.head, 'Node')
                
                obj.insertAtBegin(node)
                
            elseif index >= obj.size
                
                obj.insertAtEnd(node);
                
            else
                
                existentHead = obj.head;
                for i = 1:index - 1
                    existentHead = existentHead.next;
                end
                node.next = existentHead.next;
                node.prev = existentHead;
                existentHead.next = node;
                existentHead.next.next.prev = node;
                
                obj.size = obj.size + 1;
            end
        end
        
        function getter = removeFromBegin(obj)
            
            node = obj.head;
            
            if obj.size == 1
                
                obj.clearList();
                
            elseif ~isempty(obj.head)
                
                node.next.prev = single.empty;
                obj.head = node.next;
                obj.size = obj.size - 1;
                
            end
            
            node.next = single.empty;
            getter = node;
        end
        
        function getter = removeFromEnd(obj)
            
            node = obj.tail;
            
            if obj.size == 1
                
                obj.clearList();
                
            elseif ~isempty(obj.head)
               
                node.prev.next = single.empty;
                obj.tail = node.prev;
                obj.size = obj.size - 1;
                
            end
            
            node.prev = single.empty;
            getter = node;
        end
        
        function obj = removeMatched(obj, element)
            
            if isempty(obj.head)
                
                return
                
            end
            
            if isa(element, 'Node')
            
                data = element.data;
            
            else
                
                data = element;
                
            end
            
            if eq(obj.head.data, data)
                
                obj.removeFromBegin();
                return
                
            elseif eq(obj.tail.data, data)
                
                obj.removeFromEnd();
                return
                
            end
            
            comparate = obj.head;
            
            while ~isempty(comparate.next.next)
               
                if eq(data, comparate.next.data)
                    
                    comparate.next = comparate.next.next;
                    comparate.next.prev = comparate;
                    obj.size = obj.size - 1;
                    return
                end
                
                comparate = comparate.next;
                
            end
        
        end
        
        function obj = remove(obj, index)
            
            if isempty(obj.head)
                
                return
                
            end
           
            if index <= 0
                
                obj.removeFromBegin();
                return
                
            elseif index >= obj.size
                
                obj.removeFromEnd();
                return
                
            else
                
                if obj.size - 1 - index >= (obj.size - 1)/2
                
                    comparate = obj.head;

                    for i = 1:index - 1

                        comparate = comparate.next;

                    end

                    comparate.next = comparate.next.next;
                    comparate.next.prev = comparate;
                    obj.size = obj.size - 1;
                
                    return
                
                else
                    
                    comparate = obj.tail;
                    
                    for i = index + 1:obj.size - 2
                        
                        comparate = comparate.prev;
                        
                    end
                    
                    comparate.prev = comparate.prev.prev;
                    comparate.prev.next = comparate;
                    obj.size = obj.size - 1;
                    
                    return
                    
                end
            end
        end
        
        function getter = getPosition(obj, element)
        
            if isa(element, 'Node')
                
                data = element.data;
                
            else
                
                data = element;
                
            end
            
            positioner = obj.head;
            index = 0;
            
            while ~isempty(positioner)
                
                if positioner.data == data
                    
                    getter = index;
                    return
                
                end
                
                index = index + 1;
                positioner = positioner.next;
                
            end
            
        end
        
        function obj = Print(obj)
            
            fprintf('%d ', obj.head.data);
            
            toprint = obj.head;
            
            for i = 1:obj.size-1
                
                toprint = toprint.next;
                
                fprintf('--> %d ', toprint.data)
                
            end
        
        end
    end
end