@isTest
public class TestUtility {
 
  /**Method for inserting Bikedetails records**/
  public static List<Bike_Detail__c> createBikeDetails(Integer numOfBikes) 
    {
        List<Bike_Detail__c> bikeDetailsList=new List<Bike_Detail__c>();
        Bike_Detail__c bikeDetailsInstance;
        for(Integer i=1;i<=numOfBikes;i++)
        {
            bikeDetailsInstance=new Bike_Detail__c(Category__c ='Adventure',Colour_Variants__c='Blue',Fuel_Type__c='Petrol',Maximum_Speed__c=100);
            bikeDetailsList.add(bikeDetailsInstance);           
        }
        insert bikeDetailsList;
        return bikeDetailsList;       
    }
     
    /**Method for inserting Inventory records**/   
    public static List<Inventory__c> createInventory(Integer numOfInventory) 
    {
        List<Inventory__c> InventoryList=new List<Inventory__c>();
        Inventory__c InventoryInstance;
        for(Integer i=1;i<=numOfInventory;i++)
        {
            InventoryInstance=new Inventory__c(Total_quantity__c=50,Price__c=5000,Description__c='Bike inventory');
            InventoryList.add(InventoryInstance);           
        }
        insert InventoryList;
        return InventoryList;       
    }
    
     /**Method for inserting BikeInventory records**/ 
     public static List<BikeInventory__c> createBikeInventory(Integer numOfBikeInventory,List<Inventory__c> inventoryRecord,List<Bike_Detail__c> bikeRecord) 
    {
        List<BikeInventory__c> bikeInventoryList=new List<BikeInventory__c>();
        BikeInventory__c bikeInventoryInstance;
        for(Integer i=1;i<=numOfBikeInventory;i++)
        {
            bikeInventoryInstance=new BikeInventory__c(Quantity__c=10,Bike_Junction__c = bikeRecord[0].id,Inventory_Junction__c=inventoryRecord[0].id);
            bikeInventoryList.add(bikeInventoryInstance);           
        }
        insert bikeInventoryList;
        return bikeInventoryList;       
    }
}