public with sharing class ParentToChildAWithC{
    
   /**Relationship from A to C**/
    public void records()
    {
      List<A__c> aToC=[SELECT Id,Name,
                           (SELECT Name From C_s__r)
                            FROM A__c
                            WHERE Id
                            IN (Select AandC__c From C__c where Name LIKE 'John%')];
        for(A__c aRecord:aToC)
         {
           for(C__c cRecord:aRecord.C_s__r)
            {
              System.debug(cRecord);
            }
           System.debug(aRecord);
        }
    }   
     
}