public with sharing class BikeDetailsExtension {
public Bike_Detail__c  bikeDetailsRecord{get;set;}
  
 public BikeDetailsExtension(ApexPages.StandardController controller)
 {
    bikeDetailsRecord= (Bike_Detail__c )controller.getRecord();
 }  

/**Method to save the bike details record**/
  public PageReference save() 
  {
      try 
        {       
          insert bikeDetailsRecord; // inserts the new record into the database
          ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Your bike specifications have been saved.Thank you!')); //message dispalyed after insertion
        } 
     catch (DMLException e) 
        {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new contact.'));
          return null;
        }
         return Page.BikeSpecificationsCollectedThankYou;    
      }
  }