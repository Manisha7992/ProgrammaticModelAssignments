public with sharing class BookingPageExtension {
public ApexPages.StandardController standardController;
public Account accountRecord{get;set;}
public String vehicleId{get;set;}
      
    public BookingPageExtension (ApexPages.StandardController sc) 
    {
         standardController= sc;	
	     accountRecord =(Account)sc.getRecord();
	     accountRecord.RouteID__c=ApexPages.currentPage().getParameters().get('routeid'); 
	     accountRecord.Tickets__c=ApexPages.currentPage().getParameters().get('numberoftickets');
	     accountRecord.VehicleCapacity__c=ApexPages.currentPage().getParameters().get('capacity'); 
	     vehicleId=ApexPages.currentPage().getParameters().get('vehicleid');  	     
    }
    
    /**Click method to save the record and update the capacity value **/
   public Pagereference click()
    {   Vehicle__c vehicleObject = new Vehicle__c();    	
    	vehicleObject = [Select Capacity__c 
    	                 FROM Vehicle__c 
    	                 WHERE id=:vehicleId];
    	String capacityValue=string.valueof(vehicleObject.Capacity__c);
    	capacityValue = accountRecord.VehicleCapacity__c;
    	vehicleObject.Capacity__c=Decimal.valueOf(capacityValue);   	
        update vehicleObject; 
        List<Account> accountRecordList= [Select id,EmailAddress__c 
                                          FROM Account 
                                          WHERE EmailAddress__c=:accountRecord.EmailAddress__c];       
        if(accountRecordList.size()<=0)
        {
          Pagereference pr = standardController.save();    
          return pr;  
        }
        else
        {
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Email already exists!'));       
         }
       return null;
    }      
}