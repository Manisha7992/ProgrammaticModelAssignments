@isTest
private class TestTaskCreationOnAccount {

     /**Test method for single task creation**/
       static testMethod void positiveTestForTaskCreationOnAccount()
       {
         List<Account> accountList=TestDataFactory.createAccounts(1);       
         Task taskRecord=[Select subject FROM task where WhatId=:accountList[0].id LIMIT 1];
        
         System.assertequals(taskRecord.subject,'Meeting with:'+accountList[0].name);
       }
       

     /**Test method for bulk task creation**/
      static testmethod void toTestBulkTaskCreationOnAccount()
       {
         List<Account> accountList=TestDataFactory.createAccounts(100);      
         List<task> taskRecord= [Select subject FROM task];
        
         System.assertEquals(accountList.size(),taskRecord.size());
       }
    
    
    /**Test method for no task creation**/    
    static testmethod void toTestNoTaskCreationOnAccount()
     {
       try
         {
           Account accountRecord=new Account(EmailAddress__c='abc@gmail.com');
          
           Test.startTest();
           insert accountRecord;
           Test.stopTest();
         }       
       catch(exception e)
         {       
           System.debug('Required fields missing');       
         }               
         List<task> taskRecord= [Select subject from task];
      
         System.assertEquals(0,taskRecord.size());
     }   
    
}