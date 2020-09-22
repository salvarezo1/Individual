
/**
 * Write a description of class BinarySearck here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
import java.util.*;
public class BinarySearch
{
    
    public int[] at(Integer[] a, int el){
        List<Integer> q = new ArrayList(Arrays.asList(a));
        return BinarySearch(q, 0, q.size(), el).stream().mapToInt(i -> i).toArray();
    }
    
    public List<Integer> BinarySearch(List<Integer> Arr, int low, int high, int el){
        int Mid = (low+high)/2;
        
        if(Mid >= Arr.size()) return Arr; 
        if(Arr.get(Mid) == el){
            Arr.remove(Mid);
            high = Arr.size();
        }
        
        
        if(high <= low) return Arr;
        else{
            BinarySearch(Arr, Mid + 1, high, el);
            BinarySearch(Arr, low, Mid - 1, el);
            return Arr;
        }
    }
    
    public static void main(String[] args){
        BinarySearch b = new BinarySearch();
        for(int i = 1; i <= 1000; i++){
            
            Integer[] q = new Integer[i];
            
            for(int j = 0; j < i; j++){
                q[j] = 1;
            }
            
            if(b.at(q, 1).length != 0){
                System.out.println("Problema cuando i es: " + i);
                break;
            } else if(i == 1000)
                System.out.println("Todo correcto");
        }
    }
}
