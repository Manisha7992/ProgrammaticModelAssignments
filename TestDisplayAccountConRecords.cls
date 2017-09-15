/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestDisplayAccountConRecords {

    static testMethod void myUnitTest() {
        List<Account> accountlist=TestDataFactory.createAccounts(100);
       // insert accountlist;
        List<Contact> contactlist=TestDataFactory.createContacts(accountlist[0].id);
        insert contactlist;
        PageReference pageRef = Page.AccountSearch;
        Test.setCurrentPage(pageRef);
      	ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
      	AccountSearchClass accsearchclass=new AccountSearchClass(sc);
     	 accsearchclass.searchstring='Test';
      	Test.startTest();
			accsearchclass.acc= new List<Account>();
			Account acc = [select name from account where id=:accountlist[0].id];
			 Id [] fixedSearchResults= new Id[1];
			 fixedSearchResults[0] = acc.id;
			Test.setFixedSearchResults(fixedSearchResults);     
			accsearchclass.searchsosl(); 
			accsearchclass.recid = acc.id;
			accsearchclass.getcontactdetails();
			accsearchclass.searchsosl();
			accsearchclass.display();
			accsearchclass.clear(); 
			System.debug('@@@@@@2'+ accsearchclass.acc);	      
			//Account acc = [select name from account where id=:accountlist[0].id];
			System.debug('inserted account'+ acc);
	    Test.stopTest();
        
    }
       
    static testMethod void myUnitTest2() {
       List<Account> accountlist=TestDataFactory.createAccounts(100);
      //  insert accountlist;
        List<Contact> contactlist=TestDataFactory.createContacts(accountlist[1].id);
        insert contactlist;
        PageReference pageRef = Page.AccountSearch;
        Test.setCurrentPage(pageRef);
      	ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[1]);
      	AccountSearchClass accsearchclass=new AccountSearchClass(sc);
        accsearchclass.searchstring='Te';
        accsearchclass.acc= new List<Account>();
      	Account acc = [select name from account where id=:accountlist[1].id];
     	Id [] fixedSearchResults= new Id[1];
      	fixedSearchResults[0] = acc.id;
       	Test.setFixedSearchResults(fixedSearchResults);      
          accsearchclass.recid = acc.id;
      	  accsearchclass.searchsosl();	
      	  accsearchclass.searchVar = 'T';      
	      accsearchclass.getcontactdetails();
	      accsearchclass.display(); 
	      accsearchclass.searchVar = 'All';
	      accsearchclass.display();
	      accsearchclass.searchsosl();	      	
    }
       
     static testMethod void myUnitTest3() {
     	  List<Account> accountlist=TestDataFactory.createAccounts(100);
       //  insert accountlist;
          List<Contact> testcon=TestDataFactory.createContacts(accountlist[1].id);
          insert testcon;
          System.debug(testcon);
          Test.startTest();
			  Test.setCurrentPage(Page.AccountSearch);
			  ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[1]);
			  AccountSearchClass accsearchclass=new AccountSearchClass(sc);          
			  Contact deletedcontact = [SELECT Id, IsDeleted FROM Contact WHERE Id = :testCon[0].Id];
			  AccountSearchClass.deleteCon(deletedcontact.id);
			  list<Contact> deletedcontact1 = [SELECT Id, IsDeleted FROM Contact WHERE Id = :testCon[0].Id];
			  System.assertEquals(deletedcontact1.size(), 0);
          Test.stopTest();
    }
      
        static testMethod void errorMesageTest() {
       List<Account> accountlist=TestDataFactory.createAccounts(100);
      //  insert accountlist;
        List<Contact> contactlist=TestDataFactory.createContacts(accountlist[1].id);
        insert contactlist;
        PageReference pageRef = Page.AccountSearch;
        Test.setCurrentPage(pageRef);
      	ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[1]);
      	AccountSearchClass accsearchclass=new AccountSearchClass(sc);
        accsearchclass.searchstring='Manisha';
        accsearchclass.acc= new List<Account>();
      	Account acc = [select name from account where id=:accountlist[1].id];   	
      	accsearchclass.searchsosl();
        }
}