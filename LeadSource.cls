public with sharing class LeadSource {

//Aggregate function to group lead records by leadsource
    public void =records()
    {
        List<AggregateResult> records = [SELECT LeadSource,COUNT_DISTINCT(Name)
                                         FROM Lead
                                         GROUP BY LeadSource
                                         HAVING COUNT_DISTINCT(Name) > 10];
        Integer totalNumOfRecords = records.size();
        System.debug('Total Number Of Records = ' + totalNumOfRecords);                                               
    }
   
}

//LeadSource ls=new LeadSource();
// ls.records();