public with sharing class ContactIndustry {


//Printing contact records based on Industry tyep	
public void contactIndustry()
{	
List<Contact> conind= [SELECT Id, Name, Account.Name, Account.Industry
                                     FROM Contact
                                     WHERE Account.Industry='Media'
                                     AND Account.Active__c='Yes'];
                                     
       for(Contact con:conind)
       {
       	System.debug('Contact Name: '+con.Name+
                            '\t\tAccount Name : '+con.Account.Name);
       }
}
}

//ContactIndustry conid=new ContactIndustry();
//conid.conidrecords();