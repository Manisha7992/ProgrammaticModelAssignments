global class RemovalOfDuplicateLeads implements Database.Batchable<sObject>
 {
    public set<string> uniqueLeads = new set<string>();
    public List<Lead> duplicateLeads = new List<Lead>();
       
    global database.QueryLocator start(database.BatchableContext bc)
    {
        return database.getQueryLocator('Select id,name,email,phone from lead');
    }
    
    global void execute(database.BatchableContext bc , List<Lead> scope)
    {    
     for(Lead record : scope)
     {
          LeadConfiguration__c LeadConfiguration = LeadConfiguration__c.getInstance('Leadconfig');
          if(LeadConfiguration.Email__c)
          {
              if(record.email != null)
              {
                  if(uniqueLeads.contains(record.email))
                  {
                      duplicateLeads.add(record);
                  }
                  else
                  {
                      uniqueLeads.add(record.email);
                  }
              }
          }
          else if(LeadConfiguration.Name__c )
          {
              if(record.Name != null)
              {
                  if(uniqueLeads.contains(record.Name))
                  {
                      duplicateLeads.add(record);
                  }
                  else
                  {
                      uniqueLeads.add(record.Name);
                  }
              }
          }
     }   
      delete duplicateLeads;
    }
    
    global void finish(database.BatchableContext bc)
    {
        
    }  
}