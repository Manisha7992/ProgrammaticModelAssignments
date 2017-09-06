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
private class TestDisplayAccountsExtension {

   static testMethod void myUnitTest() {
        List<Account> accountlist=TestDataFactory.createAccounts(100);
        //insert accountlist;
        List<Contact> contactlist=TestDataFactory.createContacts(accountlist[0].id);
        insert contactlist;
        List<Opportunity> lstopp = TestDataFactory.createOpportunities(100);
        for(Opportunity opp: lstopp){
            opp.AccountId =accountlist[0].id;
        }
        insert lstopp;
        PageReference pageRef = Page.AccountSearch;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(accountlist[0]);
        Test.startTest();
        DisplayAccountsExtension accsearchclass=new DisplayAccountsExtension(sc);
        accsearchclass.recid = accountlist[0].id;
        accsearchclass.contactdetails();
        Test.stopTest();
        System.debug('Size of contactlist' + accsearchclass.contactlist.size());
        System.debug('Size of opplist' + accsearchclass.opplist.size());
        System.assertequals(10,accsearchclass.contactlist.size());
        System.assertequals(99,accsearchclass.opplist.size());
    }
           
}