public with sharing class StringOccurence 
{  

  /**Method to find the string occurence**/ 
  public void Occurence(String str)
   {
     Map<String,Integer> numchars= new Map<String,Integer>();
     for(Integer i=0;i<str.length();i++)
      {
        String charat = str.substring(i,i+1);
        if(!numchars.containsKey(charat))
        {
            numchars.put(charat,1);
        }
       else
        {
            numChars.put(charat, numChars.get(charat) + 1);
        }   
      }
   }   
   
}