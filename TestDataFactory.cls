/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class TestDataFactory {
	
public static List<Lead> createLeads(Integer numOfLeads) 
    {
    	List<Lead> leadlist=new List<Lead>();
		Lead leadInstance;
		for(Integer i=1;i<=numOfLeads;i++)
		{
			leadInstance=new Lead(LastName='LeadTest'+String.valueOf(i),FirstName='Mr',Email='lt@gmail.com',Company='Eternus',Status='Open-Contacted',Phone='123');
			leadlist.add(leadInstance);
			System.debug(leadInstance);
		}
		//insert leadlist;
		return leadlist;
        
    }
    
     public static List<Account> createAccounts(Integer numOfAccounts)
    {
    	List<Account> acclist=new List<Account>();
    	Account acc;
    	
    	for(Integer i=1;i<=numOfAccounts;i++)
		{
			acc=new Account(Name='TestAccount'+String.valueOf(i),Type='Prospect',EmailAddress__c='xyz@espl.com',AccountNumber='AC-00000'+String.valueOf(i),Domain__c='espl.com');
			acclist.add(acc);
		}
		insert acclist;
		return acclist;
    }
    
    public static List<Contact> createContacts(Id AccId)
    {
    	//Prepare the account list
    	Integer numofContacts=10;
    	List<Contact> conlist=new List<Contact>();
    	Contact con;
    	
    	for(Integer i=1;i<=numOfContacts;i++)
		{
			con=new Contact( FirstName='TestContact'+String.valueOf(i),LastName='Test',AccountID=AccId);
			conlist.add(con);
		}
		//insert conlist;
		return conlist;
    }




public static List<Case> createCases(Integer numOfcases) 
    {
    	List<Case> caselist=new List<Case>();
		Case cases;
		for(Integer i=1;i<=numOfcases;i++)
		{
			cases=new Case(Status='Working',Origin='Web');
			caselist.add(cases);
		}
		return caselist;
        
    }
    
    public static List<Contact> createContacts(Integer numOfcontacts, String email,Id AccId) 
    {
    	List<Contact> contactlist=new List<Contact>();
		Contact contacts;
		for(Integer i=1;i<=numOfcontacts;i++)
		{
			contacts=new Contact(LastName='Contact'+i,Email=email,AccountID=AccId);
			contactlist.add(contacts);
		}
		System.debug(contactlist);
		return contactlist;
        
    }
    
   public static List<Opportunity> createOpportunities(Integer numOfopportunities) 
    {
       List<Opportunity> Opplist=new List<Opportunity>();
        Opportunity opportunities;
        for(Integer i=1;i<=numOfopportunities;i++)
        {
            opportunities=new Opportunity(Name='Manisha',CloseDate=System.today(),StageName='closed won'); 
            Opplist.add(opportunities);
        }
        System.debug(Opplist);
        insert Opplist;
        return Opplist;
        
    }
    
    
}
