global class SchdeuleRemovalOfDuplicateLeads implements Schedulable{
   
   global void execute(SchedulableContext SC)
   {
   		RemovalOfDuplicateLeads remDuplicateLeads= new RemovalOfDuplicateLeads();
   		database.executebatch(remDuplicateLeads);
   } 
}

/*
SchdeuleRemovalOfDuplicateLeads rm = new scheduledMerge();
String sch = '0 0 0/3 1/1 * ? *';'; / '0 0 /3 * * *'
String jobID = system.schedule('Merge Job', sch, rm);
*/