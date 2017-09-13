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
private class TestRemovalOfDuplicateLeads {

       static testMethod void unCheckedCustomSettings() {
        
        List<lead> leadList = TestDataFactory.createLeads(2);
        insert leadlist;
        LeadConfiguration__c record  = new LeadConfiguration__c();
        record.Name='Leadconfig';
        record.Email__c = false;      
        insert record;
        
        test.startTest();
            RemovalOfDuplicateLeads obj = new RemovalOfDuplicateLeads ();
            database.executeBatch(obj,200);
        test.stopTest();
        
        List<Lead> leadList1 = [SELECT id FROM lead];
        System.assertEquals(2, leadList.size());
    }
    
     static testMethod void onlyEmailWithNoDuplication() {
        List<Lead> lead_List1 = TestDataFactory.createLeads(2);  
        insert lead_list1;   
        LeadConfiguration__c record  = new LeadConfiguration__c();
        record.Name='Leadconfig';
        record.Email__c = true;         
        insert record;
        
        test.startTest();
        RemovalOfDuplicateLeads obj = new RemovalOfDuplicateLeads ();
            database.executeBatch(obj);
        test.stopTest();
        
        List<Lead> leadList = [SELECT id FROM lead];
        System.assertEquals(1, leadList.size());
        }
        
         static testMethod void AllChecked() {
        List<Lead> lead_List1 = TestDataFactory.createLeads(2);  
        insert lead_List1;     
        LeadConfiguration__c record  = new LeadConfiguration__c();
        record.Name='Leadconfig';
        record.Email__c = false; 
        record.Name__c = true;     
        insert record;
        
        test.startTest();
        RemovalOfDuplicateLeads obj = new RemovalOfDuplicateLeads ();
            database.executeBatch(obj);
        test.stopTest();
        
        List<Lead> leadList = [SELECT id FROM lead];
        System.assertEquals(2, leadList.size());
    }
    
  
}