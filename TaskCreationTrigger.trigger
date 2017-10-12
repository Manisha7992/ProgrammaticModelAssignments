trigger TaskCreationTrigger on Account (after insert) {
    
    /**Trigger to create task on account**/
    List<task> accountTask=new List<task>();
    for(account accountRecord:Trigger.new)
    {
        task taskRecord=new task();
        taskRecord.Subject = 'Meeting with:'+accountRecord.name;
        taskRecord.Ownerid = accountRecord.Ownerid;
        taskRecord.WhatId  = accountRecord.id;
        accountTask.add(taskRecord);    
    }
    insert accountTask;
    
 }