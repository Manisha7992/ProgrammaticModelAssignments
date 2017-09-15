global class CollectionOfClosedWonOpportunities implements Database.Batchable<sObject> ,Database.stateful 
{
	global Map<Id,Map<String,List<Opportunity>>> mapContactWithOpportunity =new Map<Id,Map<String,List<Opportunity>>>();
	global Map<Id,Double> aggregateAmountAccount = new Map<Id,Double>();
	
	global Database.QueryLocator start (Database.BatchableContext bc)
	{
   return Database.getQueryLocator ('SELECT Id'+
                                             ', (SELECT Name'+
                                                     ', Amount'+
                                               ' FROM Opportunities'+ 
                                               ' WHERE StageName=\'Closed Won\''+
                                                 ' AND CloseDate=TODAY)'+
                                             ', (SELECT Contact.Email'+
                                              ' From AccountContactRoles'+
                                              ' WHERE IsPrimary = true)'+
                                             ' FROM Account'+ 
                                             ' WHERE Id IN (SELECT AccountId'+
                                                    ' FROM Opportunity'+
                                                    ' WHERE StageName= \'Closed Won\''+
                                                      ' AND CloseDate =TODAY)'	
                                        );
	 }
  
   global void execute(Database.BatchableContext bc, List<Account> scope)
    {
    	Double totalamount;
    	System.debug(Scope);
    	for(Account acc:scope)
    	{
    		mapContactWithOpportunity.put(acc.Id,new Map<String,List<Opportunity>>());
    	    mapContactWithOpportunity.get(acc.Id).put(acc.AccountContactRoles[0].Contact.Email,acc.Opportunities);
    	    totalamount=0;
    		for(Opportunity opp:acc.Opportunities){
    			if(opp.Amount!=NULL)
    			{
    			totalamount=totalamount+opp.Amount;
    			}			
    		}
    		aggregateAmountAccount.put(acc.ID,totalamount);
    	}
    }
    
    global void finish(Database.BatchableContext bc)
    {
    	List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
	    for(Id accid:mapContactWithOpportunity.keyset())
	    {
		    String emailbody = '';
		    String email = '';	
		    Map<String,List<Opportunity>> tempmap=mapContactWithOpportunity.get(accid);
		    //Set<String> lstemail=tempmap.keyset();
		    for( String emailobj : tempmap.keyset()){
		    	email= emailobj;		    	
		    }
		    List<Opportunity> lstoppty = tempmap.get(email);		    
		    for(Opportunity opp : lstoppty){
		    	
		    	 emailBody += 'Opportunity:::'+opp.Name+'\n';
                 emailBody += 'Amount:::'+opp.Amount+'\n';
                    
		    	/*emailbody = emailbody+ 'Name of opportunity '+ opp.name + 'Amount '+ opp.amount +'</br>'; */
		    }
		    emailbody = emailbody+ ' The total amount for opportunity is ' + aggregateAmountAccount.get(accid);
		    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		    mail.setToAddresses(new List<String>{email});
		    mail.setSubject('Total amount of Opportunity for Your Account ');
		    mail.setPlainTextBody('Hello,\n Following are details of opportunities that were closed won for you account today\n'+emailBody);
		  /*  mail.setHtmlBody(emailbody);*/
		    mails.add(mail);	
	    }
    	Messaging.sendEmail(mails);  	
    }
	
	
   /*Date.today().addDays(-1)*/ 
    
}