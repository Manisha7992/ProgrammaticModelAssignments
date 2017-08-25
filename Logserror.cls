public with sharing class LogsError{

//Aggregate function to insert leads and send error message to logs
 	public void insertLead(){	
 		//Lead list creation
 		Lead[] le=new List<Lead>();
		for(Integer i=0;i<5;i++)
		{
			Lead l=new Lead(FirstName='Vidya'+i,LastName='Naik');
			le.add(l);
		}	
		for(Integer i=6;i<100;i++)
		{
			Lead l=new Lead(FirstName='Vidya'+i,LastName='Naik',Company='Genpact');
			le.add(l);
		}
		
		/// DML saveresult list
 		Database.SaveResult[] srList = Database.insert(le, false);
 		
        // Iterate through each returned result
		for (Database.SaveResult sr : srList) {
   			 if (sr.isSuccess()) {
       			 // Opertaion was sucessful so get the ID of the record 
        		System.debug('Successfully inserted lead.Lead ID: ' + sr.getId());
         }
        else {       
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');            
            Logs__c log=new Logs__c();
            log.Error__c=err.getMessage();                  
            insert log;           
        }
    }
     }
 	}   
}