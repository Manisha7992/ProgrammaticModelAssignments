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
private class TestBikeDisplayController {
    
    /**Test method to perform all insertions**/
     @testSetup 
     static void setup() {
        // Create common test accounts
        List<Bike_Detail__c> testbikedetails = new List<Bike_Detail__c>();
        for(Integer i=0;i<5;i++) {
            testbikedetails.add(new Bike_Detail__c(Category__c ='Adventure',Colour_Variants__c='Blue',Fuel_Type__c='Petrol',Maximum_Speed__c=100));
        }
        insert testbikedetails;  
     }

    static testMethod void myUnitTest() {
       //set mock class
         Test.startTest();
              
         Lead le = new Lead(FirstName ='Manisha',LastName ='Naik',Phone='12345',Email='manisha@gmail.com',Company='Google',Description='Testing');
         Apexpages.StandardController sc = new Apexpages.StandardController(le);
         BikeDisplayController controller = new BikeDisplayController(sc);
         controller.lead=le;
         controller.bikeParam=1;
         controller.getbikespecifications();
         controller.details();
         controller.save();
         Test.stopTest();
        
    }
    
    static testMethod void myUnitTest2() {
       //set mock class
         Test.startTest();
          Lead le = new Lead(FirstName ='Manisha',LastName ='Naik',Phone='12345',Email='manisha@gmail.com',Company='Google',Description='Testing');
             
         Lead le2 = null;
         Apexpages.StandardController sc = new Apexpages.StandardController(le);
         BikeDisplayController controller = new BikeDisplayController(sc);
         
         controller.lead=null;
         controller.bikeParam=1;
         controller.getbikespecifications();
         controller.details();
         controller.save();
         Test.stopTest();
        
    }
}