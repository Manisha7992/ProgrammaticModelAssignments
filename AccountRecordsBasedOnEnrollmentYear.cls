public with sharing class AccountRecordsBasedOnEnrollmentYear
{

 /**Displaying account records based on enrollemnt year multiselect picklist**/ 
  public void accountRecords()
    {
       List<account> accountList = [SELECT Name,Billingcity,Enrollment_Year__c
                                      FROM Account
                                      WHERE Enrollment_Year__c INCLUDES ('2010')
                                      OR (Enrollment_Year__c INCLUDES ('2013')  AND Enrollment_Year__c INCLUDES ('2014'))];
        
        for(account acccountRecordsValue:accountList)
         {
           System.debug('Records with Enrollment Year as 2010 or 2013 and 2014:');
           System.debug(acccountRecordsValue);    
         }
    }
    
}