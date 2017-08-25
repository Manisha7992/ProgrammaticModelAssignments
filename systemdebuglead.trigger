trigger systemdebuglead on Lead (after delete, after insert, after update, before delete, before insert, before update) {
 
 	if(Trigger.isbefore){
 		if(Trigger.isinsert){
 			System.debug('Trigger.new inside before insert' + Trigger.new);			
 		}
 		if(Trigger.isupdate){
 			System.debug('Trigger.new inside before update' + Trigger.new);
 			System.debug('Trigger.newMap inside before update' +Trigger.newMap);
 			System.debug('Trigger.oldMap inside before update' +Trigger.oldMap);
 		}
 		if(Trigger.isdelete){
 			System.debug('Trigger.old inside before delete' + Trigger.old);
 		}
 	}
 		
 	if(Trigger.isafter)
 	{
 	  if(Trigger.isinsert)
 	  {
 	  	System.debug('Trigger.new inside after insert' + Trigger.new);
 	  	if(checkRecursive.runOnce())                    //Trigger to clone lead records
	   {
	     List<Lead> leadList = new List<Lead>();
	     leadList = Trigger.new.deepClone();
	     insert leadList;
	   }
 	  }
 	  if(Trigger.isupdate){
 			System.debug('Trigger.new inside after update' + Trigger.new);
 			System.debug('Trigger.newMap inside after update' +Trigger.newMap);
 			System.debug('Trigger.oldMap inside after update' +Trigger.oldMap);
 		}
 		if(Trigger.isdelete){
 			System.debug('Trigger.old inside before after' + Trigger.old);
 		}		
 		
 	}		 
}