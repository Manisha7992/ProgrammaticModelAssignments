public with sharing class AccountMapStructures {
    
    /**Method to print AccountName as key and AccountId as value**/
    public void accountNameKey()
     {
       List<Account> Accountlist=[Select name,id 
                                  FROM Account];
       Map<String,Id> accountKey=new Map<String,Id>();
        for(Account accountRecord: Accountlist)
         {
           accountKey.put(accountRecord.name,accountRecord.id);
           System.debug(accountKey);    
         }
     }
    
    /**Method to print AccountID as key and AccountObject as value**/
    public void accountIdKey()
     {
        Map<Id,Account> mapAccount = new Map<Id,Account>();       
         for( Account accountRecords : [Select id,name,billingcity 
                                       FROM Account])
           {
            mapAccount.put(accountRecords.Id,accountRecords);
            System.debug(mapAccount);
           }
     }    
     
}