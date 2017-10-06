@isTest
private class TestBikeInventoryHandler {
    
      /**Test method for deducing total quantity**/
      public static testMethod void testTotalQuantity() 
      {
        List<Bike_Detail__c> bikeDetailsList = TestUtility.createBikeDetails(5);
        List<Inventory__c> inventoryList = TestUtility.createInventory(5);
        List<BikeInventory__c> bikeInventoryList = TestUtility.createBikeInventory(5,inventoryList,bikeDetailsList );        
        Decimal quantity = inventoryList[0].Total_Quantity__c - bikeInventoryList[0].Quantity__c;      
        List<Inventory__c>  inventoryRecordlist =[select Total_Quantity__c from Inventory__c];        
              
        System.AssertEquals(inventoryRecordlist[0].Total_Quantity__c,quantity);     
      }
      
      /**Test method for zero total quantity**/
       public static testMethod void testZeroTotalQuantity() 
       {
        try
         {
	       List<Bike_Detail__c> bikeDetailsList = TestUtility.createBikeDetails(5);
	       List<Inventory__c> inventoryList = TestUtility.createInventory(5);
	       List<BikeInventory__c> testBikeInventory = new List<BikeInventory__c>();       
           testBikeInventory.add(new BikeInventory__c(Name='Bikeinventory',Quantity__c=55,Bike_Junction__c=bikeDetailsList[0].id,Inventory_Junction__c=inventoryList[0].id));          
           Inventory__c invoiceRecord=inventoryList[0];  
           invoiceRecord.Total_Quantity__c=0;
           update invoiceRecord;
           insert testBikeInventory;                         
          }
        catch(Exception e)
          {
            System.assert(e.getMessage().contains('Not sufficient quantity in inventory'));
          }
        }
  }