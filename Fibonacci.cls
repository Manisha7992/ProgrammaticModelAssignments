public with sharing class Fibonacci{

   public void fibolist(Integer n)
    {
   Integer first=0;
   Integer second=1;
   Integer next;
   for(Integer i=0;i<=n;i++)
   {
   //Fibonacci F=new Fibonacci();
  // F.fibolist(10);
   System.debug('Fibonacci series is'+second);
   next=first+second;
   first=second;
    second=next;   
        }
   }
}