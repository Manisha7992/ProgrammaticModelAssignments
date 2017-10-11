public with sharing class InsertDMLOperation{
    
   /**Method to insert Account Records**/
    public void insertAccount()
     {
        Account[] accountList=new List<Account>();
         for(Integer i=0;i<5;i++)
          {
            Account a=new Account(Name='ManishaAccount',Phone='12345',AccountNumber='50060010');
            accountList.add(a);
          }
         try
          {
            insert accountList;
          } 
          catch(DMLException e)
          {
            System.debug('Insert error has occured'+e.getMessage());
          }
     }
    
    /**Method to insert Contact Records**/
    public void insertContact()
     {  
        Account acccountRecord = new Account(Name='SFDC Account');
        insert acccountRecord;
        Id acccountRecordID = acccountRecord.ID;
        Contact[] contactList=new List<Contact>();
          for(Integer i=0;i<5;i++)
           {
             Contact contactRecord=new Contact(FirstName='Joe',LastName='Smith',AccountID=acccountRecordID);
             contactList.add(contactRecord);
           }
          try
           {
             insert contactList;
           }    
          catch(DMLException e)
           {
             System.debug('Insert error has occured'+e.getMessage());
           }
     }
    
    /**Method to insert Lead Records**/ 
    public void insertLead()
     {
        Lead[] leadList=new List<Lead>();
         for(Integer i=0;i<5;i++)
          {
            Lead leadRecord=new Lead(FirstName='Vidya',LastName='Naik');
            leadList.add(leadRecord);
          } 
         try
          {
            insert leadList;
          } 
         catch(DMLException e)
          {
             System.debug('Insert error has occured'+e.getMessage());
          }
    }
    
   /**Method to insert Opportunity Records**/           
   public void insertOpportunity()
    {
        Opportunity[] opportunityList=new List<Opportunity>();
         for(Integer i=0;i<100;i++)
         {
           Opportunity opportunityRecord=new Opportunity(Name='Manisha'+ i,StageName='Prospecting',CloseDate=date.parse('06/09/2018'),Amount=20000);
           opportunityList.add(opportunityRecord);
         }
         try
          {
            insert opportunityList;
          } 
         catch(DMLException e)
          {
            System.debug('Insert error has occured'+e.getMessage());
          }
    } 
    
}