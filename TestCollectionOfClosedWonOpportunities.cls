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
private class TestCollectionOfClosedWonOpportunities {


    @testSetup
    
    public static void dataFactory () {
        list <account> fetchedAcc_List;

        //Add Account records
        list <account> account_List = new list <account> ();
        account accRecord;
        for(integer index = 1; index <= 1; index++){
            accRecord = new account(name = 'Test'+index);
            account_List.add(accRecord);
        }
        insert account_List;
        fetchedAcc_List = [SELECT id FROM account];
       
        
        //Add Contact records
        list <contact> contact_List = new list <contact> ();
        contact conRecord;
        for(integer index = 0; index < 1; index++){
            conRecord = new contact(lastname = 'Contact'+index,
            email = 'milind@espl.com', accountId = fetchedAcc_List[index].id);
            contact_List.add(conRecord);
        }
        insert contact_List;
        
        
        //Add AccountContactRole records
       List<AccountContactRole> role_List = new List<AccountContactRole>();
       for (Contact cont : contact_List) {
           AccountContactRole role = new AccountContactRole();
           role.AccountId = cont.AccountId;
           role.ContactId = cont.Id;
           role.role = 'other';
           role.IsPrimary = true; 
           role_List.add(role);
       }
       insert role_List;
       
        
        
        //Add Opportunity records
        list<opportunity> opplist1 = new list<opportunity>();
        opportunity oppObject;
        for(integer index = 0; index < 1; index++){
            oppObject = new opportunity(Name = 'John'+index,
            CloseDate = date.today(), accountId = fetchedAcc_List[index].id,
            StageName = 'Closed Won', amount = 7000);
            opplist1.add(oppObject);
        }
        insert opplist1;
    
    
        //Add Opportunity records
        list<opportunity> opplist2 = new list<opportunity>();
        opportunity oppRecord;
        for(integer index = 0; index < 1; index++){
            oppRecord = new opportunity(Name = 'Bob'+index,
            CloseDate = date.today(), accountId = fetchedAcc_List[index].id,
            StageName = 'Closed Won', amount = 3000);
            opplist2.add(oppRecord);
        }
        insert opplist2;
    }
    
    //Test method for testing functionality of Account object
    static testMethod void testAccount() {
        list <account> fetchedAccount_List;
        Test.StartTest();
        fetchedAccount_List = [SELECT id FROM account];
        System.assertEquals(1, fetchedAccount_List.size());
        Test.StopTest();
    }
        

    //Test method for testing functionality of Contact object
    static testMethod void testContact() {
        list <contact> fetchedContact_List;
        Test.StartTest();
        fetchedContact_List = [SELECT id,email FROM contact];
        System.assertEquals(1, fetchedContact_List.size());
        for(contact con : fetchedContact_List) {
            System.assertEquals('milind@espl.com', con.email);
        }        
        Test.StopTest();
    }
        

    //Test method for testing functionality of Opportunity object
    static testMethod void testOpportunity1() {
        list <opportunity> fetchedOppprtunity_List1;
        Test.StartTest();
        fetchedOppprtunity_List1 = [SELECT id, name, amount 
                                    FROM opportunity 
                                    WHERE amount = 7000];
                                    
        System.assertEquals(1, fetchedOppprtunity_List1.size());
        for(opportunity opp : fetchedOppprtunity_List1) {
            System.assertEquals(7000, opp.amount);
        }
                
        Test.StopTest();
    }
    
    
     //Test method for testing functionality of Opportunity object
    static testMethod void testOpportunity2() {
        list <opportunity> fetchedOppprtunity_List2;
        Test.StartTest();
        fetchedOppprtunity_List2 = [SELECT id, name, amount 
                                    FROM opportunity 
                                    WHERE amount = 3000];
                                    
        System.assertEquals(1, fetchedOppprtunity_List2.size());
        Test.StopTest();
        for(opportunity opp : fetchedOppprtunity_List2) {
            
            System.assertEquals(3000, opp.amount);
        }

    }
    
    
    //Test method for testing functionality of AccountContactRole object
    static testMethod void AccountContactRole() {
        list <AccountContactRole> fetchedACR_List;
        fetchedACR_List = [select id, isPrimary from AccountContactRole];
        System.assertEquals(1, fetchedACR_List.size());
        Test.StartTest();
        for(AccountContactRole acr : fetchedACR_List) {
            System.assertEquals(true, acr.isPrimary);
        }
        Test.StopTest();
    }
        
    //Test method for testing functionality of execute method of Batch
    static testMethod void test() {
        CollectionOfClosedWonOpportunities obj = new CollectionOfClosedWonOpportunities ();
        Test.StartTest();
        ID batchprocessid = Database.executeBatch(obj,500);
        Test.StopTest();
        
    }
}