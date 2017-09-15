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
private class TestABCHandler {

    static testMethod void ABCContainerTest() {
        // TO DO: implement unit test
        List<Account> newaccount=TestDataFactory.createAccounts(1);
        List<Contact> newcontact=TestDataFactory.createContacts(2,'abc@espl.com');
        
        Test.startTest();
			insert newaccount;
			insert newcontact;       
        Test.stopTest();
        
        List<Contact> cont=[Select id,AccountId FROM Contact WHERE Email='abc@espl.com'];
        List<Account> acc=[Select id FROM Account WHERE EmailAddress__c='espl.com'];
        
        Account a=acc[0];       
        for(Contact c:cont)
        {
        	System.assertEquals(c.AccountId,a.id);
        }
        
    }
    
    
    static testMethod void ContactBlankEmailTest()
    {
    	List<Account> newaccount=TestDataFactory.createAccounts(1);
        List<Contact> newcontact=TestDataFactory.createContacts(1,null);
        
        Test.startTest();
			insert newaccount;
			insert newcontact;       
        Test.stopTest();
        
        List<Contact> cont=[Select id,AccountId FROM Contact WHERE Email=null];
        Contact c=cont[0];
        
        System.assertEquals(null,c.AccountId);
        
    }
    
     static testMethod void BulkInsertionTest()
    {
    	List<Account> newaccount=TestDataFactory.createAccounts(150);
        List<Contact> newcontact=TestDataFactory.createContacts(150,'abc@espl.com');
        
        Test.startTest();
			insert newaccount;
			insert newcontact;      
        Test.stopTest();
        
        List<Contact> cont=[Select id,AccountId FROM Contact WHERE Email='abc@espl.com'];
        List<Account> acc=[Select id FROM Account WHERE EmailAddress__c='espl.com'];
        
        System.AssertEquals(150,acc.size());
    }
}