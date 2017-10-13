@isTest
private class TestSearchOnMultipleObjects {

    /**Positive Test**/
     static testMethod void accountSearchTest() 
      {
        List<Account> accountList=TestDataFactory.createAccounts(1);
        insert accountList;
        List<Contact> contactList=TestDataFactory.createContacts(1,'m@m.com');
        insert contactList;
        List<Opportunity> opportunityList = TestDataFactory.createOpportunities(1);      
        List<Lead> leadList = TestDataFactory.createLeads(1);
        insert leadList;
        PageReference pageRef = Page.SearchOnMultipleObjects;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        SearchOnMultipleObjectsExtension searchOnMultipleObjects=new SearchOnMultipleObjectsExtension(sc);
        searchOnMultipleObjects.searchstring='Manisha';
        
        Test.startTest();
        Id [] fixedSearchResults= new list<Id>();        
        fixedSearchResults.add(accountList[0].id);
        fixedSearchResults.add(contactList[0].Id);
        fixedSearchResults.add(opportunityList[0].Id);
        fixedSearchResults.add(leadList[0].Id);      
        Test.setFixedSearchResults(fixedSearchResults);     
        searchOnMultipleObjects.searchsosl(); 
        Test.stopTest();
             
        System.assertequals(accountList.size(),searchOnMultipleObjects.accountList.size());
        System.assertequals(contactList.size(),searchOnMultipleObjects.contactList.size());
        System.assertequals(opportunityList.size(),searchOnMultipleObjects.opportunityList.size());
        System.assertequals(leadList.size(),searchOnMultipleObjects.leadList.size());                  
      }
    
    /**Negative test method**/    
    static testMethod void negativeTest() 
     {       
        List<Account> accountList=TestDataFactory.createAccounts(0);
        insert accountList;
        List<Contact> contactList=TestDataFactory.createContacts(0,'m@m.com');
        insert contactList;
        List<Opportunity> opportunityList = TestDataFactory.createOpportunities(0);      
        List<Lead> leadList = TestDataFactory.createLeads(0);
        insert leadList;
        PageReference pageRef = Page.SearchOnMultipleObjects;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        SearchOnMultipleObjectsExtension searchOnMultipleObjects=new SearchOnMultipleObjectsExtension(sc);
        
        Test.startTest();
        Id [] fixedSearchResults= new list<Id>();              
        Test.setFixedSearchResults(fixedSearchResults); 
        searchOnMultipleObjects.searchstring='';  
        searchOnMultipleObjects.searchsosl(); 
        Test.stopTest();
     
        System.assertequals(accountList.size(),searchOnMultipleObjects.accountList.size());
        System.assertequals(contactList.size(),searchOnMultipleObjects.contactList.size());
        System.assertequals(opportunityList.size(),searchOnMultipleObjects.opportunityList.size());
        System.assertequals(leadList.size(),searchOnMultipleObjects.leadList.size());                 
     }
    
    /**Bulk testmethod **/
    static testMethod void bulkTest()
     {        
        List<Account> accountList=TestDataFactory.createAccounts(100);
        insert accountList;
        List<Contact> contactList=TestDataFactory.createContacts(100,'m@m.com');
        insert contactList;
        List<Opportunity> opportunityList = TestDataFactory.createOpportunities(100);      
        List<Lead> leadList = TestDataFactory.createLeads(100);
        insert leadList;
        PageReference pageRef = Page.SearchOnMultipleObjects;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        SearchOnMultipleObjectsExtension searchOnMultipleObjects=new SearchOnMultipleObjectsExtension(sc);
        searchOnMultipleObjects.searchstring='Manisha';
        
        Test.startTest();
        Id [] fixedSearchResults= new list<Id>(); 
        for(Integer i=0;i<100;i++)
        {       
        fixedSearchResults.add(accountList[i].Id);
        fixedSearchResults.add(contactList[i].Id);
        fixedSearchResults.add(opportunityList[i].Id);
        fixedSearchResults.add(leadList[i].Id);  
        }           
        Test.setFixedSearchResults(fixedSearchResults);     
        searchOnMultipleObjects.searchsosl(); 
        Test.stopTest();
             
        System.assertequals(accountList.size(),searchOnMultipleObjects.accountList.size());
        System.assertequals(contactList.size(),searchOnMultipleObjects.contactList.size());
        System.assertequals(opportunityList.size(),searchOnMultipleObjects.opportunityList.size());
        System.assertequals(leadList.size(),searchOnMultipleObjects.leadList.size());                
     }
     
}