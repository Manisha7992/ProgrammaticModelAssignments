public with sharing class SearchOnMultipleObjectsExtension {
    
   public list <Account> accountList{get;set;}
   public list<Contact> contactList{get;set;}
   public list<Lead> leadList{get;set;}
   public list<Opportunity> opportunityList{get;set;}
   public string searchstring {get;set;} 
      
   public SearchOnMultipleObjectsExtension(ApexPages.StandardController controller) {     
   }  
   
      /**Method to perform search on multiple objects**/
      public void searchsosl()
      {
         List<List<SObject>> searchList = [FIND :searchstring IN Name FIELDS RETURNING                                      
                                          Account(Id, Name),
                                          Contact(Id, Name),
                                          Lead(Id,Name),
                                          Opportunity(Id,Name)];                                              
         accountList = (Account[])searchList[0];
         contactList = (Contact[])searchList[1];
         leadList = (Lead[])searchList[2];
         opportunityList= (Opportunity[])searchList[3];
      }
     
    }