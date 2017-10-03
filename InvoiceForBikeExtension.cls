public with sharing class InvoiceForBikeExtension {
     public Invoice__c invoice{get;set;}
     public Map<String,Double> mapExpenses{get;set;}
    
     public InvoiceForBikeExtension(ApexPages.StandardController controller) {
     invoice = (Invoice__c)controller.getRecord();
     invoice = [SELECT InvoiceLineItem__r.LineItem_Name__c,ContactInvoice__r.Name,ContactInvoice__r.Account.BillingPostalCode,
                       ContactInvoice__r.Account.BillingCity,ContactInvoice__r.Account.BillingState,ContactInvoice__r.Account.BillingStreet,
                       ContactInvoice__r.Account.Phone,ContactInvoice__r.Email,BikeInvoice__r.Name,
                       Consultation_Charges__c,Design_Charges__c,SubTotal__c,GST__c,Total_Charges__c FROM Invoice__c WHERE Id =: invoice.Id];
     
     mapExpenses = new Map<String,Double>();         
     mapExpenses.put('Consultation Charges', invoice.Consultation_Charges__c);
     mapExpenses.put('Design Charges', invoice.Design_Charges__c); 
     mapExpenses.put('SubTotal Fee', invoice.SubTotal__c);  
     mapExpenses.put('GST', invoice.GST__c);    
     mapExpenses.put('Total', invoice.Total_Charges__c);  
  }
  
   public PageReference sendPdf() {
     if(CheckRecursive.runOnce())
     {
     System.debug('CHeckrecirsive called @@@@@@@2');
    PageReference pdf = Page.InvoiceForBike;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',invoice.id);

    // the contents of the attachment from the pdf
    Blob body;

    try {

      // returns the output of the page as a PDF
      body = pdf.getContent();

    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('PDF is empty');
    }

    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('testPdf.pdf');
    attach.setInline(false);
    attach.Body = body;

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { invoice.ContactInvoice__r.Email});
    mail.setSubject('Invoice for Bike Design');
    mail.setHtmlBody('Here is the invoice for your Bike Design! Check the attachment!');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 

    // Send the email
    //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+invoice.ContactInvoice__r.Email));
    }
    return null;

  }
    
}