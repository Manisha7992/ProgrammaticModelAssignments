global class ScheduleClosedWonOpportunities implements Schedulable{
   
   global void execute(SchedulableContext SC)
   {
   		CollectionOfClosedWonOpportunities closedWonOpportunities= new CollectionOfClosedWonOpportunities();
   		database.executebatch(closedWonOpportunities);
   } 
}

/*
ScheduleClosedWonOpportunities cw = new scheduledMerge();
String sch = '0 0 1 * * *';
String jobID = system.schedule('Merge Job', sch, cw);
*/