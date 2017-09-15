/**************************************************************************************************
 * Class : LeadRestResource
 --------------------------------------------------------------------------------------------------
 * Description : Exposed this apex class as webservice and it allows for insertion,deletion and updation of lead records
 * Test Class : TestLeadRestResource
 --------------------------------------------------------------------------------------------------*/
@RestResource(urlMapping='/Lead/*')
 global with sharing class LeadRestResource {
 	
 @HttpGet
 global static List<Lead> getLead()
   {
      RestRequest request = RestContext.request;
      //RestContext.response.addHeader('Content-Type', 'application/json');   
      String LeadId= request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
      //Lead result =  [SELECT Id, Name ,company , Email , Phone, Status 
                     // FROM Lead 
                      //WHERE Id = :LeadId];    
      //return result;
      List<Lead> result1=[SELECT Id, Name ,company , Email , Phone, Status 
                          FROM Lead];
      return result1; 
   }

 @HttpPost
 global static void doPost(String firstName,String lastName,String Email,String phone,String Company)
 {
	RestRequest request = RestContext.request;
	//RestResponse res = RestContext.response;
	Lead createLead=new Lead();
	createLead.firstName = firstName;
	createLead.lastName = lastName;
	createLead.Email = Email;
	createLead.Phone = phone;
	createLead.Company = Company;
	try
	{
	  insert createLead;
      RestContext.response.addHeader('Content-Type', 'application/json');
      RestContext.response.responseBody = Blob.valueOf('{ "Lead" : "'+ createLead.id+'", "isSuccess" : "True", "Status" : "Success" }');     
	}
	catch(exception e)
	{
	 RestContext.response.addHeader('Content-Type', 'application/json');
	 RestContext.response.responseBody = Blob.valueOf('{ "Lead" : "'+ createLead.id+'", "isSuccess" : "False", "Status" : "Error" }');	
	}
	//return createLead.ID;
}

 @HttpDelete
 global static void doDelete() 
  {
	RestRequest req = RestContext.request;
	System.debug(':::::RestContext =' +req);
	String strFirstName = RestContext.request.params.get('firstName');
    String strLastName = RestContext.request.params.get('lastName');
    String strPhone = RestContext.request.params.get('phone');
    String strEmail = RestContext.request.params.get('Email');
    try
    {
    Lead record = [SELECT Id, Name ,company , Email , Phone, Status 
                      FROM Lead
                      WHERE  FirstName = :strFirstName 
                         AND LastName = :strLastName 
                         AND Phone = :strPhone 
                         AND Email = :strEmail][0];
      String tempName=record.Name;
      delete record;
      RestContext.response.addHeader('Content-Type', 'application/json');
      RestContext.response.responseBody = Blob.valueOf('{ "Lead" : "'+tempName+'", "isSuccess" : "True", "Status" : "Success" }');
    }
    catch(Exception e)
    {
       RestContext.response.addHeader('Content-Type', 'application/json');
       RestContext.response.responseBody = Blob.valueOf('{ "Lead" : "", "isSuccess" : "False", "Status" : "'+ e.getMessage() +'" }');
    }   
  }

 @HttpPatch
     global static void updateLead(String firstName,string lastName,string email,string phone)
     {
       Id resultrecordid;	
       RestRequest request = RestContext.request;
       //RestResponse response = RestResponse RestResponse();
       System.debug('firstName =' +firstName + 'lasttName = '+lastName);
       try
       {
	       lead result = [SELECT Id, FirstName, LastName ,email , phone 
	                      FROM Lead 
	                      WHERE FirstName =:firstName 
	                      AND LastName =:lastName ][0];              
	       result.email = Email;
	       result.phone = Phone;     
	       resultrecordid =result.id;
           update result;
           RestContext.response.addHeader('Content-Type', 'application/json');
           RestContext.response.responseBody = Blob.valueOf('{ "Lead" : "'+ resultrecordid +'", "isSuccess" : "True", "Status" : "Success" }');
        }
        catch(Exception e)
        {
           RestContext.response.addHeader('Content-Type', 'application/json');
           RestContext.response.responseBody = Blob.valueOf('{ "Lead" : "'+ resultrecordid + '", "isSuccess" : "False", "Status" : "Error" }');
        }
     }
    
}