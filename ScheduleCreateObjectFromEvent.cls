global class ScheduleCreateObjectFromEvent implements Schedulable{
   
   global void execute(SchedulableContext SC)
   {
   		CreateObjectFromEventBatch eventBatch= new CreateObjectFromEventBatch();
   		database.executebatch(eventBatch);
   } 
}