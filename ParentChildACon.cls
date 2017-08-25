public with sharing class ParentChildACon {

//Parentchild relationship to print where name is John
	public void records()
	{
	List<Account> actcon=[Select name,id,(Select name,id,email FROM Contacts)
	                      FROM Account 
	                      WHERE name
                          LIKE '%JOHN%'];
                          	
    for(Account acc:actcon)
    {
    	for(Contact con:acc.contacts)
    	{
    	System.debug(con);
    	}
    	System.debug(acc);
    }
}
}