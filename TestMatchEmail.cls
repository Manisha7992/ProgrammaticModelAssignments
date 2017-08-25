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
private class TestMatchEmail {
  
  //Testclass to match email records
    static testMethod void myUnitTest() {

        //Insert Account and Contact
        Account accnt=new Account(Name='TestAccount',Type='Prospect',EmailAddress__c='abc@gmail.com');
        insert accnt;
        Contact con=new Contact(FirstName='Joe',LastName='Smith',AccountID=accnt.id,email='abc@gmail.com');
        insert con;
        //Testing case record
        Case newcase=new Case(Status='Working',Origin='Web',Email__c='abc@gmail.com');
	   
        Test.startTest();
        insert newcase;
        System.debug(newcase.id);     
        Test.stopTest();
      
	    Id accountid = [Select AccountId from case where id= :newcase.id].AccountId;
        System.assertequals(accnt.id,accountid);    
    }
}