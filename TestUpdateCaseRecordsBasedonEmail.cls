@isTest
private class TestUpdateCaseRecordsBasedonEmail {

    //Testclass to match email records positive test
    static testMethod void positiveTest() 
    {
       Contact testContact = new Contact(Email='manisha@g.com',LastName='ganpat');
       insert testContact ;
       Account testAccount = new Account(Name='Raval',EmailAddress__c='manisha@g.com');
       insert testAccount;

       Case testCase = new Case(subject='new test',origin='Web',email__c='manisha@g.com');
       insert testCase;
 
       Case updatedCase =[Select accountId,contactId,email__c from Case where Id=:testCase.Id];
      
       System.assertNotEquals(testContact.Id,updatedCase.contactId);
       System.assertNotEquals(testAccount.Id,updatedCase.accountId);    
    }
    
    static testMethod void NegativeTesting() 
     { 
    Contact testContact = new Contact(Email='manisha@g.com',LastName='naik');
    insert testContact ;
    Account testAccount = new Account(Name='manisha',EmailAddress__c='manisha@g.com');
    insert testAccount;
    Case testCase = new Case(subject='new test',origin='Web',email__c='v@v.com');
    
        Test.startTest();
        insert testCase;     
        Test.stopTest();

    Case caseRecord=[Select accountId,contactId,email__c from Case where Id=:testCase.Id];      
    System.assertNotEquals(testContact.Id,caseRecord.contactId);
    System.assertNotEquals(testAccount.Id,caseRecord.accountId);     
      }
      
}