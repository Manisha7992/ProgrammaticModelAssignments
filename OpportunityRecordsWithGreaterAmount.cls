public with sharing class OpportunityRecordsWithGreaterAmount{

  /**Method to display 100 opportunity records with amount greater than 10000**/
  public void opportunityRecords()
   {    
     List<Opportunity> opportunityList=[Select id,name
                                        FROM Opportunity
                                        WHERE Amount>10000
                                        ORDER BY Createddate
                                        LIMIT 100
                                        OFFSET 50 
                                        ALL ROWS];                       
      for(Opportunity opportunityrecord:opportunityList)
       {
         System.debug('Opportunity names whose amount is greater than 10000 are');
         System.debug(opportunityrecord);
       }                                              
   }  
   
}