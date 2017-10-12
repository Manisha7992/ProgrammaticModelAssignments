public with sharing class ParentToChildAccountOpportunity {
    
  /**Display account records with opportunity closed won**/
    public static void AccountRecordsBasedOnOpp()
    {      
      List<Account> accountWithOpportunity = new List<Account>();
        for(Account accountRecord : [SELECT Id,Name 
                                     FROM Account
                                     WHERE Id in(SELECT AccountId
                                     FROM Opportunity
                                     WHERE StageName = 'Closed Won')])
          {                    
             System.debug(accountRecord.name);
          }
    }    
    
}