public with sharing class ABC_Handler 
{
      public static void Account_Contact_Association( List < Contact > contacts)
    {
        set<String> emailDomain = new set< String >();       
        for( Contact c : contacts)
        {
           if(c.email != null)
           {
           emailDomain.add(c.email.split('@').get(1)); //now emailDomain contains only domain part of mail  (eg  gmail.com)
           }
        }        
        if(!emailDomain.isEmpty())
        {
            map < String , Id > mapContainsAllAccountEmailHavingDomainEmail = new map <String , Id >();
            
            for(Account acc :[select id,Domain__c from Account where Domain__c like : emailDomain])
            
            {
                  mapContainsAllAccountEmailHavingDomainEmail.put(acc.Domain__c , acc.Id);
            }
            
            for( Contact contactInstance : contacts)
            {
                String newEmailDomain = contactInstance.email.split('@').get(1);
                if(mapContainsAllAccountEmailHavingDomainEmail.containsKey(newEmailDomain))
                {
                    contactInstance.AccountId = mapContainsAllAccountEmailHavingDomainEmail.get(newEmailDomain);
                }
                
            }
        }          
    }
	
}