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
private class TestCountryCity {
    
    
      public static testMethod void testCityPicklist(){
      
       List<City__c> citylist = new List<City__c>();
        
        for(Integer i=0;i<3;i++)
        {
            City__c record=new City__c();
            
            record.Name='Mumbai'+i;
            record.Country__c='India';              
            citylist.add(record);
        }      
          insert citylist; 
           
          test.startTest();        
	          CountryCityPicker instanceOfControllerClass = new CountryCityPicker();
	          instanceOfControllerClass.getCountriesSelectList();
	          instanceOfControllerClass.country = 'India';                        
	          instanceOfControllerClass.getCitiesSelectList();    
	          System.assertEquals(4,instanceOfControllerClass.optionscity.size());
	          System.debug(instanceOfControllerClass.optionscity.size());
	          System.debug(instanceOfControllerClass.optionscity);
	          System.assertEquals('Mumbai0',instanceOfControllerClass.optionscity[1].getvalue());
	          System.debug(instanceOfControllerClass.optionscity[1].getvalue());
          test.stopTest();
         
      } 



   public static testMethod void testNullCityPicklist(){      
            List<City__c> citylist = new List<City__c>();
            City__c record=new City__c();         
            record.Name='Mumbai';
            record.Country__c='India';              
            citylist.add(record);            
            insert citylist;
            
	        test.startTest();         
	            CountryCityPicker instanceOfControllerClass = new CountryCityPicker();
	            instanceOfControllerClass.getCountriesSelectList();
	            instanceOfControllerClass.country = '';
	            instanceOfControllerClass.city = 'Mumbai';              
	            instanceOfControllerClass.getCitiesSelectList();    
	            System.debug(instanceOfControllerClass.optionscountry);
	            System.assertEquals(1,instanceOfControllerClass.optionscountry.size());
            test.stopTest();       
      } 
      
     public static testMethod void testCountryPicklist(){
        System.debug( 'in test country : ' );        
        List<City__c> citylist = new List<City__c>();
        List<Country__c> countrylist = new List<Country__c>();
        for( Integer i=0;i<3;i++ ) {
            City__c record = new City__c();        
            record.Name = 'Indore'+i;
            record.Country__c = 'India';             
            citylist.add(record);
        }      
        insert citylist;   
        
        Country__c recordCountry = new Country__c();        
        recordCountry.Name = 'India';
        countrylist.add(recordCountry);
        insert countrylist; 
               
        test.startTest();         
            CountryCityPicker instanceOfControllerClass = new CountryCityPicker();
            instanceOfControllerClass.country = 'India';  
            System.debug( 'in test instanceOfControllerClass.country : ' +instanceOfControllerClass.country );  
            List<SelectOption> selectOptionCountry = instanceOfControllerClass.getCountriesSelectList();
            List<SelectOption> selectOptionCity = instanceOfControllerClass.getCitiesSelectList();    
            System.debug( 'selectOptionCountry : ' + selectOptionCountry );           
            System.assertEquals( 2,selectOptionCountry.size() );
            System.assertEquals( 'India' ,selectOptionCountry[1].getvalue());
        test.stopTest();   
    } 

}