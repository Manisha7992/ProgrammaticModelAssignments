public with sharing class BikeDisplayController {
	
	public Lead lead {
    get {
      if (lead == null)
        Lead = new Lead();
      return lead;
    }
    set;
  } 
    public boolean detailssection{get;set;}
    public boolean bikedetailssection{get;set;}
    public Lead lea{get;set;}
    public Bike_Detail__c bike{get;set;}
    public List<Bike_Detail__c> lstbike{get;set;}
    public Integer bikeParam{get;set;}
        
   public BikeDisplayController(ApexPages.StandardController controller) {
    lea = (Lead)controller.getRecord();
    detailssection=false;
    bikedetailssection=false;
    lstbike=[Select Category__c,Colour_Variants__c,Fuel_Type__c,Maximum_Speed__c FROM Bike_Detail__c limit 5];    
     }

   public void details(){
     detailssection=true;
   }

   public void getbikespecifications()
  {
    bikedetailssection=true;
    bike= lstbike[bikeParam];   
  }
  
   public PageReference save() {

    try {
      insert lead; // inserts the new record into the database
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new contact.'));
      return null;
    }
    return Page.LeadCreatedThankyou;
   }

}