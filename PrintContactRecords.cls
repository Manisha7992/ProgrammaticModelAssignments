public with sharing class PrintContactRecords{
    
    /**Method to print all the contact records**/
     public void records()
    {
      List<contact> conRecords = [Select Name,Id,Email,MailingCity 
                                  FROM Contact];     
       for(contact conactRecord: conRecords)
        {
          System.debug('  Id:'+conactRecord.id+'  Name:'+conactRecord.name+'  Email:'+conactRecord.email+'  Mailingcity:'+conactRecord.mailingcity);
        }
    }
  
}