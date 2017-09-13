/**************************************************************************************************
 * Class : LeadManipulatorUsingSOAP
 --------------------------------------------------------------------------------------------------
 * Description : Exposed this apex class as webservice and it allows for insertion,deletion and updation of lead records
 * Test Class : TestLeadManipulatorUsingSOAP
 --------------------------------------------------------------------------------------------------*/
global with sharing class LeadManipulatorUsingSOAP {
    
   //global class to show responses
    global class ResponseLead{
        webService String lead;
        webService Boolean IsSuccess;
        webService String status;
    }
 
   //Webservice class to insert Leads   
    webService static ResponseLead insertLeads(String FirstName, String Company, String LastName, String Email, String Phone){
        Lead lead = new Lead();
        System.debug('INside insert');
        lead.FirstName = FirstName;
        lead.Company = Company;
        lead.LastName = LastName;
        lead.Email = Email;
        lead.Phone = Phone;
        ResponseLead respobj=new ResponseLead();
        try
        {
        insert Lead;
            respobj.lead = lead.Id;
            respobj.IsSuccess = true;
            respobj.status = 'Success';
            return respobj;
        }catch(Exception e){
            respobj.lead = '';
            respobj.IsSuccess = false;
            respobj.status = e.getMessage();
            return respobj;    	
    }
    }
    
    //Webservice class to delete Leads 
    webService static ResponseLead deleteLeads(String FirstName, String LastName, String Email, String Phone){
    	ResponseLead respobj=new ResponseLead();
    	try
    	{
    		Lead lead=[Select Id,Name,Company FROM Lead WHERE FirstName=:FirstName AND LastName=:LastName AND Email=:Email AND Phone=:Phone][0];
    		String tempName=lead.Name;
    		delete lead;
    		respobj.lead=lead.Name;
    		respobj.IsSuccess = true;
    		respobj.status = 'Success';
    		return respobj;    		
    	}catch(Exception e)
    	{
    	    respobj.lead='';
    		respobj.IsSuccess = false;
    		respobj.status = e.getMessage();
    		return respobj;
       }
       }
       
     //Webservice class to update Leads
      webService static ResponseLead updateLeads(String FirstName, String LastName,String newEmail,String newPhone){
        ResponseLead respobj=new ResponseLead();
        try
        {
         Lead lead=[Select Id,Name,Company FROM Lead WHERE FirstName=:FirstName AND LastName=:LastName][0];
         lead.Email=newEmail;
         lead.Phone=newPhone;	
         update lead;
         respobj.lead=lead.Id;
         respobj.IsSuccess=true;
         respobj.status='Success';
         return respobj;
        }catch(Exception e)
        {
         respobj.lead='';
         respobj.IsSuccess=false;
         respobj.status=e.getMessage();
         return respobj;	
        }
      }
     
}