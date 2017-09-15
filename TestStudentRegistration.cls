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
private class TestStudentRegistration {

/* Creating Datafactory */
    static  void dataFactory() 
    {  
           list<Language__c> Languagelist = new list <Language__c>();
            Language__c record1 = new Language__c();
            record1.Name = 'English';
            record1.Language_Code__c = 'en';
            Languagelist.add(record1);
            Language__c record2 = new Language__c();
            record2.Name = 'German';
            record2.Language_Code__c = 'de';
            Languagelist.add(record2);
            Language__c record3 = new Language__c();
            record3.Name = 'Spanish';
            record3.Language_Code__c = 'es';
            Languagelist.add(record3);
            insert Languagelist;
    }
    
   /*Test method to check language code */  
    public static testMethod void testLanguageCode() 
    {
            list<Language__c> Languagelist = new list <Language__c>();
            Language__c record1 = new Language__c();
            record1.Name = 'English';
            record1.Language_Code__c = 'en';
            Languagelist.add(record1);
            Language__c record2 = new Language__c();
            record2.Name = 'German';
            record2.Language_Code__c = 'de';
            Languagelist.add(record2);
            Language__c record3 = new Language__c();
            record3.Name = 'Spanish';
            record3.Language_Code__c = 'es';
            Languagelist.add(record3);
            insert Languagelist;      
        StudentDetail__c recordlist = new StudentDetail__c(Name= 'Manisha');
        Apexpages.StandardController sc = new Apexpages.StandardController(recordlist);       
        StudentRegistration record = new StudentRegistration(sc);         
        Test.StartTest();
			record.selectedLang='Spanish';
			record.selectChange();
			System.assertEquals('es',record.languageCode);
        Test.StopTest();                   
    }
    
    /*Test method to test City*/
     public static testMethod void testCity() 
    {      
        StudentDetail__c recordlist = new StudentDetail__c(Name= 'Manisha');
        Apexpages.StandardController sc = new Apexpages.StandardController(recordlist);       
        StudentRegistration record = new StudentRegistration(sc);
        recordlist.Country__c='Pune';      
        Test.StartTest();
			record.selectedLang='English';
			record.selectChange();
			record.save();
			System.assertEquals('Pune',recordlist.Country__c);
        Test.StopTest();
                   
    }
    
    
    
}