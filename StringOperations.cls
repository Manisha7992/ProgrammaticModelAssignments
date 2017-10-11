public with sharing class StringOperations {
            
   //a. 
    public String replaceFirst(String target, String replacement)
    {
      String s1 = 'Welcome to @pex programming';
      String s2 = s1.replace(target, replacement);
      return s2;
    }
   
     //b.
     public String removeStartIgnoreCase(String substring)
    {
       String s1='Welcome to Apex programming';
       String s2 = s1.removeStartIgnoreCase(substring);
       return s2;
    }
    
     //d.
    public String deleteWhitespace()
    {
      String s1 = 'Welcome to Apex Programming';
      String s2 = 'WelcometoApexProgramming';   
      return s2;
    }

    //e.
    public String toUpperCase()
    {
      String myString1='Welcome to apex programming';
      myString1=myString1.toUpperCase();   
      return myString1;
    }

    //f.
   public String toLowerCase()
   {
     String s1 = 'WELCOME TO APEX PROGRAMMING';  
     return s1;
   }

   //c. 
   public void SplitFunction()
   {
    String s1='Welcome to Apex Programming';
    List <String> lstsplit=s1.split(' ');
   }
   
 }