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
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestBusBooking {
	
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
	
       /**Test method for getroutes**/
       static testMethod void testGetRoutes() {
    	 //set mock class
    	 Test.startTest();
    	 Test.setMock(HttpCalloutMock.class, new TestMockGoogleAPI());      
         Account acc = new Account(BillingPostalCode ='411021',House_No__c ='123');
         Apexpages.StandardController sc = new Apexpages.StandardController(acc);
         BusBooking controller = new BusBooking(sc);
         controller.getstoplist();
         controller.getroutes();
         Route__c route=[Select id from Route__c limit 1];
         controller.recid=route.id;
         controller.nooftickets=2;
         controller.getavailability();
         Vehicle_Route__c vehicleroute=[Select VehicleJunction__r.Capacity__c FROM Vehicle_Route__c WHERE RouteJunction__c= :controller.recid];
         controller.gotoBookingpage();
         controller.nooftickets=11;
         controller.getavailability();
         Test.stopTest();       
         System.assertEquals(5,controller.lstroutestop.size());
         }
             
       }