/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author salvarezo1
 */
public class Main{
    
    static int cont = 0;
    static int index = 1;
    
    public int callMain(){
        
        int value = 0;
        
        for(; index > 0; index--){
            value += this.main(new Tables(), value);
            cont = 0;
        }
        
        cont = 1; index = 1;
        return value;
    }
    
    public int main(Tables methodClass, int start) throws OutOfMemoryError{
        
        try{
            
            while(true){
                
                cont++;
                
                if(cont == 10){
                    index++;
                    cont=1;
                }
                
                methodClass.Multiplication(cont*(int)Math.pow(10,index)+start);
            }
            
        } catch(OutOfMemoryError a){
            
            return cont*(int)Math.pow(10, index);
            
        }
    }
    
    public static void main(String[] args){
        
        Main m = new Main();
        System.out.println(m.callMain());
        
    }
    
}
