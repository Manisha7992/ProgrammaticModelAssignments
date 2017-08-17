public class Teststring {
	
	
	public void reverse(String str)
	{
   
     String revStr='';
     for(Integer i=str.length()-1;i>=0;i--)
     {
     	revStr+=str.substring(i,i+1);
     }
     System.debug(revStr);
}
}