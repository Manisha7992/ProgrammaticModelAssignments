public with sharing class ContactsOpportunitiesOfAccountExtension{
    
  public List<Account> accountList {    
    get;    
    set;}
    
  public string recordId{get;set;}
    
  public List<contact> contactList{
    get;
    set;}
    
  public List<opportunity> opportunityList{
    get;
    set;}

    public ContactsOpportunitiesOfAccountExtension(ApexPages.StandardController  stdcontroller)
   {
     accountList=[Select Id,Name,Phone,AccountNumber,BillingCity,BillingStreet,BillingCountry,BillingPostalCode
                           FROM Account];                                    
   }
   
  /**Method to display related contact and opportunity records on click of account record**/   
  public void contactDetails()
   {
     contactList= [Select Id,Name FROM contact WHERE AccountId=:recordId];
     opportunityList= [Select Id,Name FROM opportunity WHERE AccountId=:recordId];
   }
   
}