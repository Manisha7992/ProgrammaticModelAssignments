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
private class Test_InvoiceExtension {

     public static Invoice__c createInvoices()
   {
   	   List<Account> account = TestDataFactory.createAccounts(1);
   	   insert account;
       List<Contact> contacts = TestDataFactory.createContacts(account[0].id);
       insert contacts;
       Invoice__c invoice = new Invoice__c();
       invoice.ContactInvoice__c = contacts[0].id;
       invoice.Date__c = Date.valueOf('2017-03-03');       
       invoice.Work_Hours__c=10;
       invoice.Service_Fee__c = 10000;     
       return invoice;
   }

   public static testmethod void createAndInsertInvoices()
   {
       Invoice__c invoice = createInvoices();
       insert invoice;
       test.startTest();
		   ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
		   InvoiceExtension i = new InvoiceExtension(stdController);
       test.stopTest();
       Invoice__c invobj = [Select Discount__c,Labour__c,Tax__c,Total__c from Invoice__c where id=:invoice.id];    
       System.debug('Invoice object'+ invobj);
       System.assertEquals(750,invobj.Labour__c);
       System.assertEquals(2500.00,invobj.Discount__c);
       System.assertEquals(2499.96,invobj.Tax__c);
       System.assertEquals(15749.96,invobj.Total__c);      
   }

}