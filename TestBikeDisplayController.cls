@isTest
private class TestBikeDisplayController {
    
    static testMethod void singleBikeDetailRecordTest() 
     { 
         List<Bike_Detail__c> createBikeDetailsList=TestUtility.createBikeDetails(1);
         
         Test.startTest();             
         Lead leadRecordValue = new Lead(FirstName ='Manisha',LastName ='Naik',Phone='12345',Email='manisha@gmail.com',Company='Google',Description='Testing');
         Apexpages.StandardController sc = new Apexpages.StandardController(leadRecordValue);
         BikeDisplaySiteExtension controller = new BikeDisplaySiteExtension(sc);
         controller.leadRecord=leadRecordValue;
         controller.details();               
         controller.bikeIdLiked= createBikeDetailsList[0].id;
         controller.save();
         controller.gotoBikeDetails();
         Test.stopTest(); 
            
         Lead leadRecord = [Select FirstName,LastName,Phone,Email,Company,Description,Bike_Liked__c FROM Lead WHERE id=:leadRecordValue.id];  
         System.assertEquals(createBikeDetailsList[0].id,leadRecord.Bike_Liked__c);         
     }
    
    static testMethod void bulkTest() 
     {     
         List<Bike_Detail__c> createBikeDetailsList=TestUtility.createBikeDetails(100);
         
         Test.startTest();             
         Lead leadRecordValue = new Lead(FirstName ='Manisha',LastName ='Naik',Phone='12345',Email='manisha@gmail.com',Company='Google',Description='Testing');
         Apexpages.StandardController sc = new Apexpages.StandardController(leadRecordValue);
         BikeDisplaySiteExtension controller = new BikeDisplaySiteExtension(sc);
         controller.leadRecord=leadRecordValue;
         controller.details();
         controller.bikeIdLiked= createBikeDetailsList[0].id;        
         controller.save();
         controller.gotoBikeDetails();
         Test.stopTest();   
          
         Lead leadRecord = [Select FirstName,LastName,Phone,Email,Company,Description,Bike_Liked__c FROM Lead WHERE id=:leadRecordValue.id];  
         System.assertEquals(createBikeDetailsList[0].id,leadRecord.Bike_Liked__c); 
     }
    
    static testMethod void requiredFieldMissingTest() 
     {     
         List<Bike_Detail__c> createBikeDetailsList=TestUtility.createBikeDetails(100);
         
         Test.startTest();
         PageReference pageRef = Page.BikeDisplaySite; 
         Test.setCurrentPage(pageRef);                  
         Lead leadRecordValue = new Lead(FirstName ='Manisha',LastName ='',Phone='12345',Email='manisha@gmail.com',Company='Google',Description='Testing');
         Apexpages.StandardController sc = new Apexpages.StandardController(leadRecordValue);
         BikeDisplaySiteExtension controller = new BikeDisplaySiteExtension(sc);
         controller.leadRecord=leadRecordValue;
         controller.details();
         controller.bikeIdLiked= createBikeDetailsList[0].id;        
         controller.save();         
         Test.stopTest();  
         
         List<ApexPages.Message> msgList = ApexPages.getMessages();
         System.assertEquals('Required fields are missing: [LastName]', ApexPages.getMessages()[0].getSummary());
         System.assertEquals('Error creating new lead record', ApexPages.getMessages()[1].getSummary());
     }
}