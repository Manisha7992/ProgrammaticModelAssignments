public with sharing class CreateDML {
	
	public void insertaccount()
	{
		Account[] acts=new List<Account>();
		for(Integer i=0;i<5;i++)
		{
		Account a=new Account(Name='ManishaAccount',Phone='12345',AccountNumber='50060010');
		acts.add(a);
		System.debug(a.Name);
		}
		try
		{
		insert acts;
		}	
		catch(DMLException e)
		{
		System.debug('Insert error has occured'+e.getMessage());
		}
		}
	
	public void insertcontact()
	{	
		Account acct = new Account(Name='SFDC Account');
		insert acct;
		Id acctId = acct.ID;
		Contact[] cont=new List<Contact>();
		for(Integer i=0;i<5;i++)
		{
		Contact con=new Contact(FirstName='Joe',LastName='Smith',AccountID=acctId);
		cont.add(con);
		System.debug(con.FirstName);
		}
		try
		{
		insert cont;
		}	
		catch(DMLException e)
		{
		System.debug('Insert error has occured'+e.getMessage());
		}
		}
		
		public void insertlead()
	   {
		Lead[] le=new List<Lead>();
		for(Integer i=0;i<5;i++)
		{
		Lead l=new Lead(FirstName='Vidya',LastName='Naik');
		le.add(l);
		System.debug(l.Firstname);
		}	
		try
		{
		insert le;
		}	
		catch(DMLException e)
		{
		System.debug('Insert error has occured'+e.getMessage());
		}
		}
		
		public void insertOpp()
	   {
		Opportunity[] opp=new List<Opportunity>();
		for(Integer i=0;i<100;i++)
		{
		Opportunity o=new Opportunity(Name='Manisha'+ i,StageName='Prospecting',CloseDate=date.parse('06/09/2018'),Amount=20000);
		Opp.add(o);
		System.debug(o.Name);
		}
		try
		{
		insert Opp;
		}	
		catch(DMLException e)
		{
		System.debug('Insert error has occured'+e.getMessage());
		}
		}
		
		
}