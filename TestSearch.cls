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
private class TestSearch {

    static testMethod void accountSearchTest() {
        // TO DO: implement unit test
        List<Account> accountlist=TestDataFactory.createAccounts(100);
        //insert accountlist;
        List<Contact> contactlist=TestDataFactory.createContacts(accountlist[0].id);
        insert contactlist;
        List<Opportunity> opplist = TestDataFactory.createOpportunities(100);
       // insert opplist;
        List<Lead> leadlist = TestDataFactory.createLeads(100);
        insert leadlist;
        PageReference pageRef = Page.AccountSearch;
        Test.setCurrentPage(pageRef);
      	ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
      	Searchclass recordsearchclass=new Searchclass(sc);
        recordsearchclass.searchstring='Manisha';
      	Test.startTest();
      	Account acc = [select name from account where id=:accountlist[0].id];
      	recordsearchclass.acc= new List<Account>();
     	Id [] fixedSearchResults= new list<Id>();  	
      	fixedSearchResults.add(accountlist[0].id);
      	fixedSearchResults.add(contactlist[0].Id);
      	fixedSearchResults.add(leadlist[0].Id);
      	fixedSearchResults.add(opplist[0].Id);
       	Test.setFixedSearchResults(fixedSearchResults);     
      	recordsearchclass.searchsosl(); 
      	Test.stopTest();
      	System.debug('Size of accountlist' + recordsearchclass.acc.size());
        System.debug('Size of contactlist' + recordsearchclass.con.size());
        System.debug('Size of opportunitylist' + recordsearchclass.con.size());
        System.debug('Size of leadlist' + recordsearchclass.opty.size());
        System.assertequals(1,recordsearchclass.con.size());
        System.assertequals(1,recordsearchclass.opty.size());      
    }
}