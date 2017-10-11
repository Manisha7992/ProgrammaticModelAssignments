public with sharing class DisplayLeadRecordsBasedOnStatus{
    
  /**Aggregate function to group lead records by leadstatus**/
    public void records()
    {   
       AggregateResult[] records = [SELECT Status,LeadSource,COUNT(Name)
                                    FROM Lead
                                    group by Status,LeadSource];
       Map<String,Map<String,Integer>> leadMap = new Map<String,Map<String,Integer>>();                                                                                 
       System.debug(records); 
   
        for(AggregateResult leadRecords: records)
         {
            String status = (String)leadRecords.get('Status');
             if(!leadMap.containsKey(status))
              {
                leadMap.put(status, new Map<String,Integer>());
              }      
            String source = (String)leadRecords.get('LeadSource');
            Integer leadCount = (Integer)leadRecords.get('expr0');
            leadMap.get(status).put(source,leadCount);
         }                                     
        System.debug(leadMap);
    }     
           
}