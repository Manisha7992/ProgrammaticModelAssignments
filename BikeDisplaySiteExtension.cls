public with sharing class BikeDisplaySiteExtension {

    public boolean bikeTableSection{get;set;}
    public boolean detailsSection{get;set;}
    public Lead leadRecord{get;set;}
    public List<Bike_Detail__c> listBike{get;set;}
    public String bikeIdLiked{get;set;}    
    
    public BikeDisplaySiteExtension (ApexPages.StandardController controller) 
    {
	   leadRecord = (Lead)controller.getRecord();
	   bikeTableSection = true;
	   detailsSection=false;
	   listBike=[Select Category__c,Colour_Variants__c,Photo__c,Fuel_Type__c,Maximum_Speed__c 
	             FROM Bike_Detail__c limit 10000];    
     }

/**Section to be displayed onclick of Like button**/
   public void details()
   {
     detailsSection=true;
     bikeTableSection = false;
   }

/**Method to save the leadrecord on adding details**/ 
   public PageReference save() 
   {
    try 
     {
       leadRecord.Bike_Liked__c=bikeIdLiked;
       insert leadRecord ;
     } 
    catch (DMLException e) 
     {
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new lead record'));
       return null;
     }
    return Page.LeadCreatedThankyou;   
   }
   
/**Method to redirect to bike details page**/   
   public PageReference gotoBikeDetails()
   {
	  Pagereference pr=Page.BikeDetails;
	  pr.setredirect(true);
	  return pr;   
   }
   
}