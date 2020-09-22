/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author salvarezo1
 */
import java.util.*;

public class Main{
    
    static int cont = 1;
    static int index = 1;
    
    public int callMain(){
        
        int value = 0;
        
        for(; index >= 0; index--){
            value += this.main(new BionicBee(), value);
            cont = 0;
        }
        
        cont = 1; index = 1;
        return value;
    }
    
    public int main(BionicBee methodClass, int actValue) throws OutOfMemoryError{
        
        ArrayList<Object[]> Ll= new ArrayList<Object[]>();

        try{
            
            while(true){
                
                if(cont == 10){
                    index++;
                    cont=1;
                }
                
                Object[] Tuple = {1, 3};
                for(int i = 0; i < actValue + cont*(int)Math.pow(10,index); i++)
                    Ll.add(Tuple);
                //methodClass.BionicBee(actValue + cont*(int)Math.pow(10,index));
                //int[][] el = new int[actvalue + cont*(int)Math.pow(10,index)][actvalue + cont*(int)Math.pow(10,index)];
                
                cont++;
            }
            
        } catch(OutOfMemoryError a){
            
            return (cont == 1) ? 9*(int)Math.pow(10, index-1) : (cont-1)*(int)Math.pow(10, index);
            
        }
    }
    
    public static void main(String[] args){
        
        Main m = new Main();
        System.out.println(m.callMain());
        
    }
    
}
