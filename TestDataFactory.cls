@isTest
public class TestDataFactory {
	
	/**Testmethod to insert leads**/
     public static List<Lead> createLeads(Integer numOfLeads) 
      {
	    //Prepare the lead list
    	 List<Lead> leadList=new List<Lead>();
		 Lead leadInstance;
		 for(Integer i=1;i<=numOfLeads;i++)
		 {
			leadInstance=new Lead(LastName='LeadTest'+String.valueOf(i),Company='Eternus',Status='Open-Contacted',Phone='123');
			leadlist.add(leadInstance);
			System.debug(leadInstance);
		 }
		 //insert leadList;
		 return leadList;       
      }
    
	 /**Testmethod to insert accounts**/
     public static List<Account> createAccounts(Integer numOfAccounts)
     {
    	//Prepare the account list
    	List<Account> accountList=new List<Account>();
    	Account acc;
    	
    	for(Integer i=1;i<=numOfAccounts;i++)
		{
			acc=new Account(Name='TestAccount'+String.valueOf(i),AccountNumber='AC-00000'+String.valueOf(i));
			acclist.add(acc);
		}
		//insert accountList;
		return accountList;
     }
    
	/**Testmethod to insert contacts**/
    public static List<Contact> createContacts(Id AccId)
     {
    	//Prepare the account list
    	Integer numofContacts=10;
    	List<Contact> contactList=new List<Contact>();
    	Contact contactRecord;
    	
    	for(Integer i=1;i<=numOfContacts;i++)
		{
			contactRecord=new Contact( FirstName='TestContact'+String.valueOf(i),LastName='Test',AccountID=AccId);
			conlist.add(contactRecord);
		}
		//insert contactList;
		return contactList;
     }
    
	/**Testmethod to insert cases**/
    public static List<Case> createCases(Integer numOfcases) 
     {
    	List<Case> caseList=new List<Case>();
		Case cases;
		for(Integer i=1;i<=numOfcases;i++)
		{
			cases=new Case(Status='Working',Origin='Web');
			caseList.add(cases);
		}
		return caseList;        
     }
    
	/**Testmethod to insert contacts**/
    public static List<Contact> createContacts(Integer numOfcontacts, String email) 
    {
    	List<Contact> contactList=new List<Contact>();
		Contact contacts;
		for(Integer i=1;i<=numOfcontacts;i++)
		{
			contacts=new Contact(LastName='Contact'+i,Email=email);
			contactList.add(contacts);
		}
		return contactList;       
    }
       
}