public with sharing class AccountBilling {

public void birecords()
{
List<account> accbilling = [Select name,phone,BillingState 
                            FROM Account 
                            WHERE BillingState 
                            NOT IN('MAHARASHTRA','KERALA') 
                            ORDER BY BillingState DESC NULLS 
                            LAST LIMIT 10000];
 
for(account accb:accbilling)
{
 System.debug('Account names whose billing states are other than maharashtra and kerala are:');
 System.debug(accb);
}
                           
}

}