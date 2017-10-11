public with sharing class FibonacciSeries{

  /**Method to print fibonacci series**/
    public void fibonacciSeries(Integer n)
  {
   Integer first=0;
   Integer second=1;
   Integer next;
   for(Integer i=0;i<=n;i++)
   {
     next=first+second;
     first=second;
     second=next;   
    }
  }
}