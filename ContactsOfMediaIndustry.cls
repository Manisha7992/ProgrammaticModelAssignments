public with sharing class ContactsOfMediaIndustry {
    
 /**Printing contact records based on type of Industry**/   
 public void contactIndustry()
   {    
     List<Contact> conind= [SELECT Id, Name, Account.Name, Account.Industry
                            FROM Contact
                            WHERE Account.Industry='Media'
                            AND Account.Active__c='Yes'];                                   
       for(Contact con:conind)
        {
        System.debug('Contact Name: '+con.Name+ 'Account Name : '+con.Account.Name);
        }
   }
   
}