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
private class TestInvoiceForBikeExtension {

       public static Invoice__c createInvoices()
     {
   	   List<Account> account = TestDataFactory.createAccounts(1);
   	   //insert account;
       List<Contact> contacts = TestDataFactory.createContacts(2,'manisha@gmail.com',account[0].id);
       insert contacts;
       List<Bike_Detail__c> bikedetail = new List<Bike_Detail__c>();
        for(Integer i=0;i<5;i++) {
        bikedetail.add(new Bike_Detail__c(Fuel_Tank_Capacity__c='100',Category__c='Racer'));
        }    
        insert bikedetail;
       System.debug('bikes are'+bikedetail);
       Invoice__c invoice = new Invoice__c();
       invoice.ContactInvoice__c = contacts[0].id;  
       invoice.BikeInvoice__c = bikedetail[0].id;
       invoice.Date__c = Date.valueOf('2017-03-03');           
       invoice.Consultation_Charges__c=500;
       invoice.Design_Charges__c = 2000;      
       return invoice;
   }
   
    public static testmethod void createAndInsertInvoices()
   {
       Invoice__c invoice = createInvoices();
       insert invoice;
       test.startTest();
       ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
       InvoiceForBikeExtension i = new InvoiceForBikeExtension(stdController);
       test.stopTest();
       Invoice__c invobj = [Select SubTotal__c,GST__c,Total_Charges__c,ContactInvoice__c FROM Invoice__c WHERE id=:invoice.id];
           
       System.assertEquals(2500,invobj.SubTotal__c);
       System.assertEquals(125,invobj.GST__c);
       System.assertEquals(2625,invobj.Total_Charges__c);     
   }
   
   

  public static testMethod void testPdfEmailer()
     {
    
    Invoice__c invoice = createInvoices();
    insert invoice;
    
    PageReference pref = Page.InvoiceForBike;
    pref.getParameters().put('id',invoice.id);
    Test.setCurrentPage(pref);

     ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
     InvoiceForBikeExtension inv = new InvoiceForBikeExtension(stdController);

    Test.startTest();     
    //System.assertEquals(2,inv.invoice.size());

    // populate the field with values
     // invoice.ContactInvoice__c = contacts[0].id;  
     
    // submit the record
    pref = inv.sendPdf();
    Test.stopTest(); 
     }
  
}