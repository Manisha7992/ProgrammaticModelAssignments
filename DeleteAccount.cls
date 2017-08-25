public with sharing class DeleteAccount {

//Deleting account records created in last 90days	
public void deleterecords()
{
	List<Account> acc=new List<Account>();
	acc=[SELECT Id FROM Account 
	     WHERE  Active__c='No' AND 
	     CreatedDate = LAST_90_DAYS];
	     try
	     {
	     	delete acc;
	     	System.debug('Inactive records deleted');
	     } 
	     catch(DMLException ex)	
	     {
	     	System.debug('Not deleted'+ex.getMessage());
	     }
	     
}   
}