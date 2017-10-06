public with sharing class BookingPageController {
public ApexPages.StandardController standardcontroller;
public Account acc{get;set;}
public String vehicleid{get;set;}
      
    public BookingPageController(ApexPages.StandardController sc) 
    {
	     standardcontroller= sc;	
	     acc =(Account)sc.getRecord();
	     acc.RouteID__c=ApexPages.currentPage().getParameters().get('routeid'); 
	     acc.Tickets__c=ApexPages.currentPage().getParameters().get('numoftickets');
	     acc.VehicleCapacity__c=ApexPages.currentPage().getParameters().get('capacity'); 
	     vehicleid=ApexPages.currentPage().getParameters().get('vehicleid');  
	     system.debug('vehicle capacity decreased'+acc.VehicleCapacity__c);
    }
    
    /**Click method to save the record and update the capacity value **/
   public Pagereference click()
    {    	
    	Vehicle__c vehicleobj = new Vehicle__c();    	
    	vehicleobj = [Select Capacity__c FROM Vehicle__c where id=:vehicleid];
    	string s1=string.valueof(vehicleobj.Capacity__c);
    	s1 = acc.VehicleCapacity__c;
    	vehicleobj.Capacity__c=Decimal.valueOf(s1);
    	System.debug('value of capcity'+vehicleobj.Capacity__c);
    	System.debug('id,name of vehicle is'+vehicleobj);
        update vehicleobj; 
        Pagereference pr=standardcontroller.save();  
        return pr;
    }      
}