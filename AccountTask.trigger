trigger AccountTask on Account(after insert) {
		
	//Trigger to create task on account
	List <task> acctask=new List<task>();
	for(account a:Trigger.new)
	{
		task t=new task();
		t.Subject='Meeting with:'+a.name;
		t.Ownerid=a.Ownerid;
		t.WhatId = a.id;
		acctask.add(t);	
	}
    insert acctask;
}