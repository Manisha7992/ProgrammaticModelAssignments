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
private class TestLeadManipulatorUsingSoap {

    //Testmethod for inserting leads
    static testMethod void testInsertLeads() {
        LeadManipulatorUsingSOAP.ResponseLead respLead=new LeadManipulatorUsingSOAP.ResponseLead();
        
        test.startTest();
       	 respLead = LeadManipulatorUsingSOAP.insertLeads('Manisha','IBM','Naik','manishanaik@gmail.com','12345');
        test.stopTest(); 
     
        Lead lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD][0];
        System.assertEquals('IBM', lead.Company);
        System.assertEquals('Manisha Naik', lead.Name);
        System.assertEquals('manishanaik@gmail.com', lead.Email);
        System.assertEquals('12345', lead.Phone);
        System.assertEquals(true,respLead.IsSuccess);
        System.assertEquals('Success',respLead.status);
        System.assertEquals(lead.Id,respLead.lead); 
        
    }   
  
     //Testmethod for deleting leads
    static testMethod void testDeleteLeads() {
        List<lead> leadList = TestDataFactory.createLeads(1);
        Lead lead = leadList[0];
        insert lead;
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.deleteLeads('Mr','LeadTest1','lt@gmail.com','123');
        test.stopTest();
        System.assertEquals(true,response.IsSuccess);
        System.assertEquals('Success',response.status);
    }
  
     //Testmethod for updating leads
    static testMethod void testUpdateLeads() {
        List<lead> leadList = TestDataFactory.createLeads(1);
        Lead lead = leadList[0];
        insert lead;
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.updateLeads('Mr','LeadTest1','updatedviarest@gmail.com','0000000');
        test.stopTest();
        lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD][0];
        System.assertEquals('Eternus', lead.Company);
        System.assertEquals('updatedviarest@gmail.com', lead.Email);
        System.assertEquals('0000000', lead.Phone);
        System.assertEquals(true,response.IsSuccess);
        System.assertEquals('Success',response.status);
        System.assertEquals(lead.Id,response.lead);
    }
    
    //Testmethod for insert method which shows error when company field is empty
    static testMethod void testExceptionInsertLeads() {
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.insertLeads('Manisha','','Naik','abc@gmail.com','12345');
        test.stopTest();
        System.assertEquals(false,response.IsSuccess);
        System.assertNOTEquals('Success',response.status);
        System.assertEquals('',response.lead);
    }
    
     //Testmethod for delete method which shows error when given incorrect firstname
    static testMethod void testExceptionDeleteLeads() {
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.deleteLeads('Mr1','LeadTest1','lt@gmail.com','123');
        test.stopTest();
        System.assertEquals(false,response.IsSuccess);
        System.assertNOTEquals('Success',response.status);
        System.assertEquals('',response.lead);
    }
    
    //Testmethod for update method which shows error when firstname is not given
    static testMethod void testExceptionUpdateLeads() {
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.updateLeads('','LeadTest1','lt@gmail.com','123');
        test.stopTest();
        System.assertEquals(false,response.IsSuccess);
        System.assertNOTEquals('Success',response.status);
        System.assertEquals('',response.lead);
    }
}