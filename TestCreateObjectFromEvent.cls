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
private class TestCreateObjectFromEvent {

   static testmethod void  TestJson()
   {
      List<event> eve=EventFactory.createEvents(1,'{"attributes":{"type":"Account"}, "Name": "Vickytest"}',True);
      Test.startTest();
      CreateObjectFromEventBatch co=new CreateObjectFromEventBatch();
      Database.ExecuteBatch(co); 
      Test.stopTest();
      
      List<Account> acclist=[Select Id,Name FROM Account];
      System.assertEquals('Vickytest',acclist[0].Name);
   
   } 
   
   static testmethod void  TestBlankJson()
   {
      List<event> eve=EventFactory.createEvents(1,'{"attributes":{"type":"Account"}, "Name": ""}',False);
      insert eve;
      try
      {
      Test.startTest();
      CreateObjectFromEventBatch co=new CreateObjectFromEventBatch();
      Database.ExecuteBatch(co); 
      Test.stopTest();
      }
      catch(Exception e)
      {  
      Boolean temp = e.getmessage().contains('Required fields are missing: [Name]');
      List<Account> acclist=[Select Id,Name FROM Account];
      System.assertEquals(true,temp);
     }  
   }   
}