@isTest
private class TestInvoiceForBikeExtension {
	   
   /**Testmethod for invoice generation**/
    public static testmethod void createAndInsertInvoices()
   {
       Invoice__c invoice = InvoiceFactory.createInvoices();
       insert invoice;
       Decimal subTotal=invoice.Consultation_Charges__c + invoice.Design_Charges__c;
       Decimal GST=subTotal*0.05;
       Decimal Total= subTotal + GST;
       test.startTest();
       ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
       InvoiceForBikeExtension invoiceForBike = new InvoiceForBikeExtension(stdController);
       test.stopTest();
       Invoice__c invobj = [Select SubTotal__c,GST__c,Total_Charges__c,ContactInvoice__c FROM Invoice__c WHERE id=:invoice.id];
           
       System.assertEquals(subTotal,invobj.SubTotal__c);
       System.assertEquals(GST,invobj.GST__c);
       System.assertEquals(Total,invobj.Total_Charges__c);     
   }
     
   /**Testmethod for invoice generation when design charges is blank**/
    public static testmethod void zeroDesignAndConsultationCharges()
   {
       Invoice__c invoice = InvoiceFactory.createInvoices();
       invoice.Design_Charges__c = 0;
       invoice.Consultation_Charges__c = 0;
       insert invoice;
       Decimal subTotal=invoice.Consultation_Charges__c + invoice.Design_Charges__c;
       Decimal GST=subTotal*0.05;
       Decimal Total= subTotal + GST;      
       test.startTest();
       ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
       InvoiceForBikeExtension invoiceForBike = new InvoiceForBikeExtension(stdController);
       test.stopTest();
       Invoice__c invobj = [Select SubTotal__c,GST__c,Total_Charges__c,ContactInvoice__c FROM Invoice__c WHERE id=:invoice.id];
           
       System.assertEquals(subTotal,invobj.SubTotal__c);
       System.assertEquals(GST,invobj.GST__c);
       System.assertEquals(Total,invobj.Total_Charges__c);   
   }
 
   
    /**Testmethod for mail**/
  	 public static testMethod void testPdfEmailer()
     {    
	    Invoice__c invoice = InvoiceFactory.createInvoices();
	    insert invoice;	    
	    PageReference pref = Page.InvoiceForBike;
	    pref.getParameters().put('id',invoice.id);
	    Test.setCurrentPage(pref);
	    ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
	    InvoiceForBikeExtension invoiceForBike = new InvoiceForBikeExtension(stdController);	
	    Test.startTest();     
	    pref = invoiceForBike.sendPdf();
	    Test.stopTest(); 
     }      
}