public with sharing class AsscociatedContactsOfAccount{

  /**Method to print associated contact records**/
  public void records()
   {
     List<account> accountContactRecords= [Select Name,(Select Id, Name, MailingCity, MobilePhone From Contacts) From Account];
      for(account accountContact:accountContactRecords)
       {
         System.debug(accountContact.Name);
          for(contact contactRecords:accountContact.contacts)
           {
             System.debug(contactRecords);
           }
       }
   }  
    
}