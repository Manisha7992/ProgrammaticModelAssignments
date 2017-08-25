trigger UpdatingCases on Case (after update, before insert) {


//Trigger to update case records based on email	
if(Trigger.isBefore)
{
	if(Trigger.isinsert)
	{
		Set<String> caseemail = new Set<String>();
		for(Case cs : trigger.new){
			if(cs.Email__c != null && (cs.Origin=='Web'||cs.Origin=='Chat'||cs.Origin=='Email')){
				caseemail.add(cs.Email__c);
			}
		}
		List<Account> lstAcc = [Select id,EmailAddress__c from Account where EmailAddress__c in : caseemail];
		Map<String,Account> mapemail_account = new Map<String,Account>();
		for(Account acc : lstAcc){
			mapemail_account.put(acc.EmailAddress__c,acc);
		}
		List<Contact> lstcon = [Select id,Email from Contact where Email in : caseemail];
		Map<String,Contact> mapemail_contact = new Map<String,Contact>();
		for(Contact con : lstcon){
			mapemail_contact.put(con.Email,con);
		}
		
		for(Case cs :trigger.new ){
			if(cs.Email__c != null && (cs.Origin=='Web'||cs.Origin=='Chat'||cs.Origin=='Email')){
				Account ac = mapemail_account.get(cs.Email__c);
				if(ac != null){
					cs.AccountID= ac.id;
				}
				Contact co = mapemail_contact.get(cs.Email__c);
				if(co !=null){
					cs.ContactID= co.id;
				}
			}
			
		} 
	}
}
    
}