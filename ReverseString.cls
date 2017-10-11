public class ReverseString{

 /**Method to reverse the string**/
 public void reverseString(String str)
    {   
     String reverseStringValue='';
     for(Integer i=str.length()-1;i>=0;i--)
     {
        reverseStringValue+=str.substring(i,i+1);
     }
   }
}