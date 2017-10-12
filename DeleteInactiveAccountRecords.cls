public with sharing class DeleteInactiveAccountRecords {

  /**Deleting inactive account records created in last 90days**/
    public void deleteRecords()
     {
       List<Account> accountList=new List<Account>();
       accountList=[SELECT Id FROM Account 
                    WHERE  Active__c='No' AND 
                    CreatedDate = LAST_90_DAYS];
         try
         {
            delete accountList;
            System.debug('Inactive records deleted');
         } 
         catch(DMLException ex) 
         {
            System.debug('Not deleted'+ex.getMessage());
         }       
     }  
      
}