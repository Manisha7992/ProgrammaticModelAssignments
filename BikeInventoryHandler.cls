public class BikeInventoryHandler
{
public static void inventoryDeduction(Map<id,BikeInventory__c> mapBikeInventory)
 {    
    Set<Id> inventoryIds= new Set<Id>();
    Map<id,Integer>inventoryIdQuantity =new map<id,Integer>();
    Map<id,BikeInventory__c>mapInventoryId_BikeInventory=new map<id,BikeInventory__c>();
    List<Inventory__c> updateInventory = new List<Inventory__c>(); 
    List<Inventory__c> listInventory = new List<Inventory__c> ();
    
    for(BikeInventory__c bikeInventory: mapBikeInventory.values())
    {
       inventoryIds.add(bikeInventory.Inventory_Junction__c);
       inventoryIdQuantity.put(bikeInventory.Inventory_Junction__c,Integer.valueof(bikeInventory.Quantity__c));
       mapInventoryId_BikeInventory.put(bikeInventory.Inventory_Junction__c,bikeInventory);     
    }
    
    listInventory = [Select Total_Quantity__c,id from Inventory__c where id in :inventoryIds ];    
     //Inventory is deduced based on the quantity added 
    for(Inventory__c inventory:listInventory )
     {
        Integer quantity =inventoryIdQuantity.get(inventory.id);
        inventory.Total_Quantity__c= inventory.Total_Quantity__c-quantity ;
        if(inventory.Total_Quantity__c<=0)
        {
         BikeInventory__c bikeInventoryObject=mapInventoryId_BikeInventory.get(inventory.id);   
         bikeInventoryObject.Quantity__c.addError('Not sufficient quantity in inventory');
        }
        else
        updateInventory.add(inventory);
      }
    update updateInventory;
  }
}