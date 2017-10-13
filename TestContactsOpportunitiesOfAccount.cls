@isTest
private class TestContactsOpportunitiesOfAccount{

  /**To test when related contacts and opportunities of account are displayed**/
    static testMethod void positiveTest() 
     {
        List<Account> accountList=TestDataFactory.createAccounts(1);
        List<Contact> contactList=TestDataFactory.createContacts(accountlist[0].id);
        insert contactlist;
        List<Opportunity> opportunityList = TestDataFactory.createOpportunities(1);
        for(Opportunity opportunityRecord: opportunityList)
        {
            opportunityRecord.AccountId =accountlist[0].id;
        }
        PageReference pageRef = Page.DisplayContactsOpportunitiesOfAccount;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        Test.startTest();
        ContactsOpportunitiesOfAccountExtension contactsOpportunitiesOfAccount=new ContactsOpportunitiesOfAccountExtension(sc);
        contactsOpportunitiesOfAccount.recordId = accountlist[0].id;
        contactsOpportunitiesOfAccount.contactDetails();
        Test.stopTest();

        System.assertequals(10,contactsOpportunitiesOfAccount.contactList.size());
        System.assertequals(1,contactsOpportunitiesOfAccount.opportunityList.size());
     }
    
    /**Bulktest when related contacts and opportunities of account are displayed**/
    static testMethod void bulkTest() 
     {
        List<Account> accountList=TestDataFactory.createAccounts(100);
        List<Contact> contactList=TestDataFactory.createContacts(accountlist[0].id);
        insert contactlist;
        List<Opportunity> opportunityList = TestDataFactory.createOpportunities(100);
        for(Opportunity opportunityRecord: opportunityList)
        {
            opportunityRecord.AccountId =accountlist[0].id;
        }
        PageReference pageRef = Page.DisplayContactsOpportunitiesOfAccount;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        Test.startTest();
        ContactsOpportunitiesOfAccountExtension contactsOpportunitiesOfAccount=new ContactsOpportunitiesOfAccountExtension(sc);
        contactsOpportunitiesOfAccount.recordId = accountlist[0].id;
        contactsOpportunitiesOfAccount.contactDetails();
        Test.stopTest();

        System.assertequals(10,contactsOpportunitiesOfAccount.contactList.size());
        System.assertequals(100,contactsOpportunitiesOfAccount.opportunityList.size());
     }
    
    /**Negativetest when no related opportunities of account are displayed**/
    static testMethod void negativeTest() 
     {
        List<Account> accountList=TestDataFactory.createAccounts(1);   
        List<Opportunity> opportunityList = TestDataFactory.createOpportunities(0);
        for(Opportunity opportunityRecord: opportunityList)
        {
            opportunityRecord.AccountId =accountlist[0].id;
        }
        PageReference pageRef = Page.DisplayContactsOpportunitiesOfAccount;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        Test.startTest();
        ContactsOpportunitiesOfAccountExtension contactsOpportunitiesOfAccount=new ContactsOpportunitiesOfAccountExtension(sc);
        contactsOpportunitiesOfAccount.recordId = null;
        contactsOpportunitiesOfAccount.contactDetails();
        Test.stopTest();
        
        System.assertequals(opportunityList.size(),contactsOpportunitiesOfAccount.opportunityList.size());
     }
    
}