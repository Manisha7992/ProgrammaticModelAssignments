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
private class TestLeadClone {
    
	//Test class to clone lead records 
    static testMethod void clonetest1() {
        // TO DO: implement unit test    
        List<lead> leadrecords=TestDataFactory.createLeads(1);
        Test.startTest();
        insert leadrecords;
        Test.stopTest();
        
        List<Lead> cloneGeneration =new List<Lead>([Select id FROM Lead WHERE LastName='LeadTest1']);
        System.debug(cloneGeneration);
        Integer size = cloneGeneration.size();
        System.assertEquals(2,size);    
    }
    
	//Test class to handle bulk lead clone
     static testMethod void clonetest2() {
     	
     	List<lead> leadrecords=TestDataFactory.createLeads(100);
        Test.startTest();
        insert leadrecords;
        Test.stopTest();

		List<Lead> cloneGeneration =new List<Lead>([Select id FROM Lead WHERE LastName like'LeadTest%']);
        Integer size = cloneGeneration.size();
        System.assertEquals(200,size); 
     	
     }
}