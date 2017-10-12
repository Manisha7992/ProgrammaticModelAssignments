public with sharing class LeadInsertWithErrorInLogs{
    
  /**Aggregate function to insert leads and send error message to logs**/
    public void insertLead()
    {   
       //Lead list creation
       Lead[] leadList=new List<Lead>();
        for(Integer i=0;i<5;i++)
        {
           Lead leadRecord=new Lead(FirstName='Vidya'+i,LastName='Naik');
           leadList.add(leadRecord);
        }   
        for(Integer i=6;i<100;i++)
        {
            Lead leadRecord=new Lead(FirstName='Vidya'+i,LastName='Naik',Company='Genpact');
            leadList.add(leadRecord);
        }
        
        /// DML saveresult list
        Database.SaveResult[] saveResultList = Database.insert(leadList, false);
        
        // Iterate through each returned result
        for (Database.SaveResult saveResultRecord : saveResultList)
        {
             if (saveResultRecord.isSuccess()) 
             {
                // Operation was successful so get the ID of the record 
                System.debug('Successfully inserted lead.Lead ID: ' + saveResultRecord.getId());
             }
             else 
             {       
               // Operation failed, so get all errors                
              for(Database.Error err : saveResultRecord.getErrors()) 
               {
                 System.debug('The following error has occurred.');            
                 Logs__c log=new Logs__c();
                 log.Error__c=err.getMessage();                  
                 insert log;           
               }
             }
        }
    }    
     
}