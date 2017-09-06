public with sharing class DisplayAccountsExtension {
	
public List<Account> accList {	
	get;	
	set;}
	
public string recid{get;set;}
	
public  List<contact> contactlist{
	get;
	set;}
	
public List<opportunity> opplist{
	get;
	set;
}
	
public string eventid{get;set;}	

 public DisplayAccountsExtension(ApexPages.StandardController  stdcontroller) {
	acclist=[Select Id,Name,Phone,AccountNumber,BillingCity,BillingStreet,BillingCountry,BillingPostalCode
	                       FROM Account];	
                                  
 }
       
  public void contactdetails(){
    contactlist= [Select Id,Name FROM contact WHERE AccountId=:recid];
    opplist=[Select Id,Name FROM opportunity WHERE AccountId=:recid];
 }
}