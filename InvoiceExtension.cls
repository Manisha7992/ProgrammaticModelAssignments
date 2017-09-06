public with sharing class InvoiceExtension {
	 public Invoice__c invoice{get;set;}
     public Map<String,Double> mapExpenses{get;set;}
	
	 public InvoiceExtension(ApexPages.StandardController controller) {
		invoice = (Invoice__c)controller.getRecord();
		invoice = [SELECT InvoiceLineItem__r.LineItem_Name__c,ContactInvoice__r.Name,ContactInvoice__r.Account.BillingPostalCode,
						   ContactInvoice__r.Account.BillingCity,ContactInvoice__r.Account.BillingState,ContactInvoice__r.Account.BillingStreet,
						   ContactInvoice__r.Account.Phone,ContactInvoice__r.Email,
						   Service_Fee__c,Labour__c,Discount__c,Tax__c,Total__c FROM Invoice__c WHERE Id =: invoice.Id];
	    mapExpenses = new Map<String,Double>();	    
		mapExpenses.put('Service Fee', invoice.Service_Fee__c);
        mapExpenses.put('Labour ', invoice.Labour__c);
        mapExpenses.put('Discount', invoice.Discount__c);
   	    mapExpenses.put('Tax', invoice.Tax__c);
        mapExpenses.put('Total', invoice.Total__c);  	  
   }    
}