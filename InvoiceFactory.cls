@isTest
public class InvoiceFactory {
  
    /**Test method for inserting invoices**/
     public static Invoice__c createInvoices()
     {
       List<Bike_Detail__c> createBikeDetailsList=TestUtility.createBikeDetails(10);
   	   List<Account> account = TestDataFactory.createAccounts(1);
       List<Contact> contacts = TestDataFactory.createContacts(2,'manisha@gmail.com',account[0].id);
       insert contacts;            
       Invoice__c invoice = new Invoice__c();
       invoice.ContactInvoice__c = contacts[0].id;  
       invoice.BikeInvoice__c = createBikeDetailsList[0].id;
       invoice.Date__c = Date.valueOf('2017-03-03');           
       invoice.Consultation_Charges__c=500;
       invoice.Design_Charges__c = 2000;
       return invoice;
   }   
}