public with sharing class Opstring {
	
	
   //a. 
    public String replaceFirsta(String target, String replacement)
    {
    String s1 = 'Welcome to @pex programming';
	String s2 = s1.replace(target, replacement);
	System.debug(s2);
	return s2;
    }
   
      //b.
     public String removeStartIgnoreCase(String substring)
    {
    	String s1='Welcome to Apex programming';
    	String s2 = s1.removeStartIgnoreCase(substring);
	   System.debug( s2);
	   return s2;
    }
    
     //d.
    public String deleteWhitespace()
    {
    String s1 = 'Welcome to Apex Programming';
	String s2 = 'WelcometoApexProgramming';
	System.debug(s1.deleteWhitespace());
	return s2;
    }

//e.
    public String toUpperCase()
    {
    String myString1='Welcome to apex programming';
    myString1=myString1.toUpperCase();
    System.debug(myString1);
    return myString1;
    }

//f.
public String toLowerCase()
{
     String s1 = 'WELCOME TO APEX PROGRAMMING';
	System.debug(s1.toLowerCase());
	   return s1;
}

//c. 
public void SplitFunction()
{
	String s1='Welcome to Apex Programming';
	List <String> lstsplit=s1.split(' ');
	System.debug(lstsplit.size());
	System.debug(lstsplit);
	
	
}
    }