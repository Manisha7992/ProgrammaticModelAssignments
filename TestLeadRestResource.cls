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
private class TestLeadRestResource {

  //Testmethod to get lead records
    static testMethod void testGetLeads() {
        List<lead> leadList = TestDataFactory.createLeads(100);
        ID recordId = leadList[0].Id;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead/'+recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        test.startTest();     
 	       List<Lead> lead = LeadRestResource.getLead();       
        test.stopTest();
        
        System.assert(lead != null);
      
    }
    
 //Testmethod to insert lead records
 static testMethod void testInsertLeads() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        test.startTest();     
              LeadRestResource.doPost('Manisha','Naik','manishanaik@gmail.com','123','ESPL');        
        test.stopTest();
        
        Lead lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD][0];
        System.assert(Lead!= null);
        System.debug('lead list' +lead);
        System.assertEquals('ESPL', lead.Company);
        System.assertEquals('Manisha Naik',lead.Name);
        System.assertEquals('123',lead.Phone);
        System.assertEquals('manishanaik@gmail.com',lead.Email);
        //converting response json into map of strings i.e deserializing
        System.debug('RestContext.response = ' +RestContext.response);
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();//converts a blob to unencoded string
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);//used to deserialize he string
        System.debug('map = ' +mapResponse);
        System.assertEquals('True',mapResponse.get('isSuccess'));
        System.assertEquals('Success',mapResponse.get('Status'));
        System.assertEquals(lead.Id,mapResponse.get('Lead'));       
 }
 
 //Testmethod for exception when inserting lead records
 static testMethod void testInsertLeadsError() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        test.startTest();     
              LeadRestResource.doPost('Manisha','Naik','manishanaik@gmail.com','123','');        
        test.stopTest();
        
        //converting response json into map of strings i.e deserializing
        System.debug('RestContext.response = ' +RestContext.response);
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();//converts a blob to unencoded string
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);//used to deserialize he string
        System.debug('map = ' +mapResponse);
        System.assertEquals('False',mapResponse.get('isSuccess'));
        System.assertEquals('Error',mapResponse.get('Status'));
              
 }
 
   //Testmethod to delete lead records
    static testMethod void testDeleteLeads() {
        List<lead> leadList = TestDataFactory.createLeads(1);
        insert leadList;
        Lead lead = leadList[0];      
        System.debug('Lead ='+lead);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead';
        System.debug('requestUri ='+request );
        request.params.put('firstName',lead.FirstName);
        request.params.put('lastName',lead.LastName);
        request.params.put('Email',lead.Email);
        request.params.put('phone',lead.Phone);
        request.httpMethod = 'DELETE';
        RestContext.request = request;   
        System.debug('RestContext =' +request);
        RestContext.response = response;
        System.debug('RestContext =' +response);
        
        test.startTest();       
        LeadRestResource.doDelete();       
        test.stopTest();
       
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);  
        System.debug('mapResponse ='+mapResponse);           
        System.assertEquals('True',mapResponse.get('isSuccess'));
        System.assertEquals('Success',mapResponse.get('Status'));
    }
    
    //Testmethod for exception when deleting lead records
    static testMethod void testDeleteLeadsError() {
        List<lead> leadList = TestDataFactory.createLeads(1);
        insert leadList;
        Lead lead = leadList[0];      
        System.debug('Lead ='+lead);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead';
        System.debug('requestUri ='+request );
        request.params.put('firstName',lead.FirstName);
        request.params.put('lastName',lead.LastName);
        
        request.params.put('phone',lead.Phone);
        request.httpMethod = 'DELETE';
        RestContext.request = request;   
        System.debug('RestContext =' +request);
        RestContext.response = response;
        System.debug('RestContext =' +response);
        
        test.startTest();       
        	LeadRestResource.doDelete();       
        test.stopTest();
       
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);  
        System.debug('mapResponse ='+mapResponse);           
        System.assertEquals('False',mapResponse.get('isSuccess'));
        System.assertEquals('List index out of bounds: 0',mapResponse.get('Status'));
    }
  
   //Testmethod to update lead records
    static testMethod void testUpdateLeads() {
        List<lead> leadList = TestDataFactory.createLeads(1);       
        Lead lead = leadList[0];
        insert lead;
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead/';
        request.httpMethod = 'Patch';
        RestContext.request = request;
        RestContext.response = response;
        
        test.startTest();            
            LeadRestResource.updateLead('Mr','LeadTest1','updatelead@gmail.com','0000000');        
        test.stopTest();
        
        lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD WHERE Id =:lead.Id];
        System.debug('list is'+lead);
        
        System.assertEquals('Eternus', lead.Company);
        System.assertEquals('updatelead@gmail.com', lead.Email);
        System.assertEquals('0000000', lead.Phone);
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.debug('response is'+mapResponse);
        System.assertEquals('True',mapResponse.get('isSuccess'));
        System.assertEquals('Success',mapResponse.get('Status'));
        System.assertEquals(lead.Id,mapResponse.get('Lead'));
    }
    
    //Testmethod for exception when updating lead records
     static testMethod void testUpdateLeadsError() {
        List<lead> leadList = TestDataFactory.createLeads(1);       
        Lead lead = leadList[0];
        insert lead;
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Lead/';
        request.httpMethod = 'Patch';
        RestContext.request = request;
        RestContext.response = response;
        
        test.startTest();           
            LeadRestResource.updateLead('Mrs','LeadTest1','lt@gmail.com','0000000');       
        test.stopTest();
           
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.debug('response is'+mapResponse);
        System.assertEquals('False',mapResponse.get('isSuccess'));
        System.assertEquals('Error',mapResponse.get('Status'));
           }
    

}