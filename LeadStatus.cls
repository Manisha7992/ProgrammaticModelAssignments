public with sharing class LeadStatus {

//Aggregate function to groupby leadstatus	
public void records()
{
//Map<String,Map<String,Integer>>	
AggregateResult[] records = [SELECT Status,LeadSource,COUNT(Name)
                                         FROM Lead
                                         group by Status,LeadSource];
 Map<String,Map<String,Integer>> leadMap = new Map<String,Map<String,Integer>>();                                                                                 
System.debug(records); 
   
for(AggregateResult ar : records)
   {
	String status = (String)ar.get('Status');
	 if(!leadMap.containsKey(status))
	 {
	 	leadMap.put(status, new Map<String,Integer>());
	 }      
       String source = (String)ar.get('LeadSource');
       Integer leadCount = (Integer)ar.get('expr0');
       leadMap.get(status).put(source,leadCount);
        }                                     
        System.debug(leadMap);
}	
	 
}