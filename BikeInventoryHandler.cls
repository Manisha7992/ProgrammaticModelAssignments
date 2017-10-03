public class BikeInventoryHandler
{
public static void inventoryDeduction(Map<id,BikeInventory__c> mapbikeinventory)
{    
    Set<Id> inventoryids= new Set<Id>();
    Map<id,Integer>inventoryid_quantity =new map<id,Integer>();
    Map<id,BikeInventory__c>mapinventoryid_bikeinventory=new map<id,BikeInventory__c>();
    List<Inventory__c> updinventory = new List<Inventory__c>(); 
    List<Inventory__c> lstinventory = new List <Inventory__c> ();
    
    for(BikeInventory__c bikeinventory: mapbikeinventory.values()){
       inventoryids.add(bikeinventory.Inventory_Junction__c);
       inventoryid_quantity.put(bikeinventory.Inventory_Junction__c,Integer.valueof(bikeinventory.Quantity__c));
       mapinventoryid_bikeinventory.put(bikeinventory.Inventory_Junction__c,bikeinventory);     
    }
    lstinventory = [Select Total_Quantity__c,id from Inventory__c where id in :inventoryids ];
    
    for(Inventory__c inv:lstinventory ){
        integer quantity =inventoryid_quantity.get(inv.id);
        inv.Total_Quantity__c= inv.Total_Quantity__c-quantity ;
        if(inv.Total_Quantity__c<=0)
        {
         BikeInventory__c obj=mapinventoryid_bikeinventory.get(inv.id);   
        obj.Quantity__c.addError('Not sufficient quantity in inventory');
        }
        else
        updinventory.add(inv);
    }
    update updinventory;
}

}