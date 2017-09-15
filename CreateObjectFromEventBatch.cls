global class CreateObjectFromEventBatch implements Database.Batchable<sObject>{
	
	 global database.QueryLocator start(database.BatchableContext bc)
     {
        return database.getQueryLocator('Select Id,Json__c,Object_Name__c FROM EVENT WHERE Json__c!=NULL AND Object_Name__c!=NULL');
     }
    
	  global void execute(database.BatchableContext bc , List<Event> scope)
     {
    	List<SObject> lstsobject=new List<SObject>();
    	for(Event ev:scope)
    	{
    		/*Call globaldescribe to get the Map containing object */
    		Map<String, Schema.SObjectType> gd= Schema.getGlobalDescribe();
    		Schema.SObjectType st=gd.get(ev.Object_Name__c);
    		System.debug(gd);
    		
    		/*Instantiate the sobject*/
    		Sobject s = st.newSobject();
    	
    	   /*Deserializing the json*/
    	   s=(SObject)JSON.deserializeStrict(ev.Json__c,SObject.class);		
       	   lstsobject.add(s);
       	   System.debug('TESTING'+s);
    	}
    	   insert lstsobject;
    	   delete scope;
       }
   
	
	
	 global void finish(database.BatchableContext bc)
    {
        
    } 		
}

/*
{"attributes":{"type":"Account"}, "Name": "Vickytest"}

*/