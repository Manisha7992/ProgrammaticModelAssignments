public with sharing class FindTestInMultipleObjects{
    
  /**SOSL query to perform search on multiple objects**/
    public void findRecords()
    {       
      List<List<SObject>> searchList = [FIND 'test*' IN Name FIELDS RETURNING 
                                        Contact(Id, Name),
                                        Account(Id, Name),
                                        Lead(Id,Name),
                                        User(Id,Name)];
      Contact[] searchContacts = (Contact[])searchList[0];                                            
      Account[] searchAccounts = (Account[])searchList[1];
      Lead[] searchLeads = (Lead[])searchList[2];
      User[] searchUsers = (User[])searchList[3];
      
       for (Contact contactRecord : searchContacts)
       {
         System.debug('Contact id:'+contactRecord.id+' Name:'+contactRecord.Name);
       }
       
       for (Account accountRecord : searchAccounts) 
       {
         System.debug('Account id:'+accountRecord.id+' Name:'+accountRecord.Name);
       }  
    
       for (Lead leadRecord : searchLeads)
       {
         System.debug('Lead id:'+leadRecord.id+' Name:'+leadRecord.Name);
       }
         
       for (User userRecord : searchUsers)
       {
         System.debug('User id:'+userRecord .id+' Name:'+userRecord .Name);
       }         
   }
   
}