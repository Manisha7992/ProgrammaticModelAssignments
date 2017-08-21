public with sharing class ContactDemo {
	
	public void records()
    {
    List<contact> conRecords = [Select Name,Id,Email,MailingCity From Contact]; 
    
    for(contact con: conRecords)
    {
    	System.debug('  Id:'+con.id+'  Name:'+con.name+'  Email:'+con.email+'  Mailingcity:'+con.mailingcity);
    }
    
}
}