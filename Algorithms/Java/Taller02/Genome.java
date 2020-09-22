public class Genome{
    public int SubseqLength(String Seq1, String Seq2){
        return pairStar(Seq1, Seq2, "", 0).length();
    }
    
    public String longSubseq(String str1, String str2){
        return pairStar(str1, str2, "", 0);
    }
    
    private String pairStar(String str1, String str2, String answer, int pivote) {
        int may = (str1.length() > str2.length()) ? str1.length() : str2.length();
        int min = (may == str1.length()) ? str2.length() : str1.length();
  
        if(min != 0 && pivote < str2.length()){
            if(str1.charAt(0) == str2.charAt(pivote))
            return pairStar(str1.substring(1), this.reWrite(str2, pivote), answer + str1.charAt(0), 0);
            return pairStar(str1, str2, answer, pivote + 1);
        } if(min == 0) return answer;
        return pairStar(str1.substring(1), str2, answer, 0);
    }
    
    private String reWrite(String write, int Elim){
        if(Elim != 0 && Elim < write.length()-1)
        return write.substring(0,Elim) + write.substring(Elim+1);
        else if(Elim == 0)
        return write.substring(1);
        else if(Elim == write.length()-1)
        return write.substring(0,Elim);
        return write;
    }
}