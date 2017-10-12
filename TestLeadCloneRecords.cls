@isTest
private class TestLeadCloneRecords {

   //Test class to clone lead records 
    static testMethod void positiveTest() 
    {
        // TO DO: implement unit test    
        List<lead> leadList=TestDataFactory.createLeads(1);
        Test.startTest();
        insert leadList;
        Test.stopTest();
        
        Integer expectedsize = leadList.size()*2;
        List<Lead> cloneGeneration =new List<Lead>([Select id FROM Lead WHERE LastName='LeadTest1']);
        Integer size = cloneGeneration.size();       
        System.assertEquals(expectedsize ,size);    
    }
    
    //Test class to handle bulk lead clone
     static testMethod void bulkTest() 
      {     
        List<lead> leadList=TestDataFactory.createLeads(100);
        Test.startTest();
        insert leadList;
        Test.stopTest();
        
        Integer expectedsize = leadList.size()*2;
        List<Lead> cloneGeneration =new List<Lead>([Select id FROM Lead WHERE LastName like'LeadTest%']);
        Integer size = cloneGeneration.size();
        System.assertEquals(expectedsize ,size);       
     }
     
     //Test class for negative test
     static testMethod void negativeTest() 
      {
        Lead leadList= new Lead(Company='Reynolds Inc.');       
          try 
          {
            Test.startTest();
            insert leadList;
            Test.stopTest();
          } 
         catch (Exception e) 
          {
           System.assert(e.getMessage().contains('Required fields are missing'));
          }    
      }
               
}