public with sharing class Accouncont {

public void records()
{
List<account> acconrecords= [Select Name,(Select Id, Name, MailingCity, MobilePhone From Contacts) From Account];

for(account accon:acconrecords)
{
	System.debug(accon.Name);
	for(contact con:accon.contacts)
	{
	System.debug(con);
	}
}
}    
}