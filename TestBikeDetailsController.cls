@isTest
private class TestBikeDetailsController {

    static testMethod void bikeDetailsInsertionTest() 
     { 
         Test.startTest();
         Bike_Detail__c bikeDetailRecordList = new Bike_Detail__c(Category__c ='Adventure',Colour_Variants__c='Blue',Fuel_Type__c='Petrol',Maximum_Speed__c=100);            
         Apexpages.StandardController sc = new Apexpages.StandardController(bikeDetailRecordList);
         BikeDetailsExtension controller = new BikeDetailsExtension(sc);
         controller.save();
         Test.stopTest();
         
         List<Bike_Detail__c> bikeDetailList = [Select id,Category__c from Bike_Detail__c];
         System.assertequals(bikedetailrecordlist.Category__c,bikeDetailList[0].Category__c);               
     }
}