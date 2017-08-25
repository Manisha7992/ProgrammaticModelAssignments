public with sharing class FindTest {

//SOSL query to search on multiple objects	
public void find(){		
 List<List<SObject>> searchList = [FIND 'test*' IN Name FIELDS RETURNING 
                                                Contact(Id, Name),
                                                Account(Id, Name),
                                                Lead(Id,Name),
                                                User(Id,Name)];
    Contact[] searchContacts = (Contact[])searchList[0];                                            
    Account[] searchAccounts = (Account[])searchList[1];
    Lead[] searchLeads = (Lead[])searchList[2];
    User[] searchUsers = (User[])searchList[3];
    
   
	for (Contact c : searchContacts) {
   		 System.debug('Contact id:'+c.id+'  Name:'+c.Name);
	}
    
     
    for (Account a : searchAccounts) {
     System.debug('Account id:'+a.id+'   Name:'+a.Name);
         }  
    
     for (Lead l : searchLeads){
     System.debug('Lead id:'+l.id+'   Name:'+l.Name);
         }
         
     for (User u : searchUsers){
     System.debug('User id:'+u.id+'   Name:'+u.Name);
         }   
       
   }
}