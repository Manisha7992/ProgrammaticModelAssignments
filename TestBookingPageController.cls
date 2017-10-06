/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organimyUnitTestzation. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestBookingPageController {
	
	/**Test method to perform all insertions**/
	 @testSetup 
	 static void setup() {
        // Create common test accounts
        List<Stop__c> teststops = new List<Stop__c>();
        for(Integer i=0;i<5;i++) {
            teststops.add(new Stop__c(Name = 'Stop'+i,School__c='School'+i,	Location__Latitude__s = 18.54163,Location__Longitude__s = 73.80241));
        }
        insert teststops;    
        
        List<Route__c> testroute = new List<Route__c>();
        for(Integer i=0;i<5;i++) {
        	testroute.add(new Route__c(Name='Route'+i,From__c='Pashan',To__c='Aundh'));
        }    
        insert testroute;
        
        List<Route_Stop__c> testroutestops = new List<Route_Stop__c>();
        for(Integer i=0;i<5;i++)
        {
           testroutestops.add(new Route_Stop__c(Name='RouteStop'+i,Route__c=testroute[i].id,Stop__c=teststops[i].id));
        }
        insert testroutestops;
        
        List<Vehicle__c> testvehicle = new List<Vehicle__c>();
        for(Integer i=0;i<5;i++)
        {
          testvehicle.add(new Vehicle__c(Capacity__c=10));
        }
        insert testvehicle;
        
        List<Vehicle_Route__c> testvehiclejunction = new List<Vehicle_Route__c>();
        for(Integer i=0;i<5;i++)
        {
         testvehiclejunction.add(new Vehicle_Route__c(Name='VehicleRoute1',RouteJunction__c=testroute[i].id,VehicleJunction__c=testvehicle[i].id));
        }
        insert testvehiclejunction;
      }
	
  /**Test method for click and pagereference parameters of booking page**/
    static testMethod  void testClick(){
    	 Account acc = new Account(Name ='Manisha',Phone ='12345',BillingStreet='RKStreet',EmailAddress__c='manisha@espl.com');        
         Test.setCurrentPageReference(new PageReference('Page.BookingPage')); 
         Route__c route=[Select id FROM Route__c limit 1];
         System.currentPageReference().getParameters().put('routeid', route.id);
         System.currentPageReference().getParameters().put('numoftickets', String.Valueof(2));
         Vehicle__c vehicle=[Select id,Capacity__c FROM Vehicle__c limit 1];
         System.currentPageReference().getParameters().put('capacity', String.Valueof(8));
         System.currentPageReference().getParameters().put('vehicleid', vehicle.id);        
         Apexpages.StandardController sc = new Apexpages.StandardController(acc);
         BookingPageController controller = new BookingPageController(sc);
         controller.click();
         Vehicle__c vehicle1=[Select id,Capacity__c FROM Vehicle__c WHERE id=:vehicle.id];
         System.assertEquals(8,vehicle1.Capacity__c);
         
    }
}