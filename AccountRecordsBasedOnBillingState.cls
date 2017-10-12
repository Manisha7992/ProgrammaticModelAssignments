public with sharing class AccountRecordsBasedOnBillingState{

  /**Method to display account records where billing states are not maharashtra and kerala**/
  public void accountRecords()
   {
     List<account> listAccount = [Select name,phone,BillingState 
                                 FROM Account 
                                 WHERE BillingState 
                                 NOT IN('MAHARASHTRA','KERALA') 
                                 ORDER BY BillingState DESC NULLS 
                                 LAST LIMIT 10000];
      for(account accountrecord:listAccount)
       {
          System.debug('Account name whose billing states are other than maharashtra and kerala are:');
          System.debug(accountrecord);
       }                           
   }
    
}