trigger UpdatingCasesWithEmailOfAccountAndContact on Case (after update, before insert) {
    
 /**Trigger to update case records based on email**/    
  if(Trigger.isBefore)
   {
     if(Trigger.isinsert)
      {
        Set<String> caseEmail = new Set<String>();
        for(Case caseRecord : trigger.new)
        {
            if(caseRecord.Email__c != null && (caseRecord.Origin=='Web'||caseRecord.Origin=='Chat'||caseRecord.Origin=='Email'))
            {
                caseEmail.add(caseRecord.Email__c);
            }
        }
        
        List<Account> listAccount = [Select id,EmailAddress__c from Account where EmailAddress__c in : caseEmail];
        Map<String,Account> mapEmailAccount = new Map<String,Account>();
        for(Account accountRecord : listAccount)
        {
            mapEmailAccount.put(accountRecord.EmailAddress__c,accountRecord);
        }
        
        List<Contact> listContact= [Select id,Email from Contact where Email in : caseEmail];
        Map<String,Contact> mapEmailContact = new Map<String,Contact>();
        for(Contact contactRecord : listContact)
        {
            mapEmailContact.put(contactRecord.Email,contactRecord);
        }
        
        for(Case caseRecord :trigger.new )
        {
            if(caseRecord.Email__c != null && (caseRecord.Origin=='Web'||caseRecord.Origin=='Chat'||caseRecord.Origin=='Email'))
            {
                Account accountRecordValue = mapEmailAccount.get(caseRecord.Email__c);
                if(accountRecordValue != null)
                 {
                    caseRecord.AccountID= accountRecordValue.id;
                 }
                Contact contactRecordValue = mapEmailContact.get(caseRecord.Email__c);
                if(contactRecordValue !=null)
                 {
                    caseRecord.ContactID= contactRecordValue.id;
                 }
             }
            
         } 
        
      }
   }
    
}