public with sharing class StaticDeclaration {
    
    Integer a=10,b=10;
    public static void print()
     {
       System.debug('Inside static method');
     }

    public void debug()
     {
       Integer c=a+b;
       System.debug(c);
       System.debug('Hello world');
     }
    
}