class Solution {
    public int getMaxRepetitions(String s1, int n1, String s2, int n2) {
        String k = this.repiteString(s2, n2);
        return this.Repetitions(k, k, this.repiteString(s1, n1), 0, 0);
    }
    
    private int Repetitions(String unchanged, String s1, String s2, int cont, int swivel){
        int min = (s2.length() < s1.length()) ? s2.length() : s1.length();
        
        if(min != 0 && swivel < s2.length()){
            if(s1.charAt(0) == s2.charAt(swivel))
                return Repetitions(unchanged, s1.substring(1), (swivel < s2.length()-1) ? s2.substring(swivel + 1) : "", cont + 1, 0);
            return Repetitions(unchanged, s1, s2, cont, swivel + 1);
        } if(min == 0){
            if(s1.length() == 0 && s2.length() != 0) return Repetitions(unchanged, unchanged, s2, cont, 0);
            return cont/unchanged.length();
        }
        return cont/unchanged.length();
    }
    
    private String repiteString(String entry, int nTimes){
        String R = entry;
        for(nTimes = nTimes; nTimes > 1; nTimes--){
            entry += R;
        }
        return entry;
    }
}