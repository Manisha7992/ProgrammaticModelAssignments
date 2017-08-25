public with sharing class Accountpicklist {


//Querying account records based on enrollment year	
 public void records()
    {
         List<account> accountList = [SELECT Name,Billingcity,Enrollment_Year__c
                                      FROM Account
                                      WHERE Enrollment_Year__c INCLUDES ('2010')
                                      OR (Enrollment_Year__c INCLUDES ('2013')  AND Enrollment_Year__c INCLUDES ('2014'))];
        
        for(account accon:accountList)
        {
        System.debug('Records with Enrollment Year as 2010 or 2013 and 2014:');
        System.debug(accon);
       
    }
    }
}