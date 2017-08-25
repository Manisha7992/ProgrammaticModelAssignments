public with sharing class ParenttochildAC {
	
//Relation from A to C
	public void records()
	{
	List<A__c> achild=[SELECT Id,Name,
                           (SELECT Name From C_s__r)
                           FROM A__c
                           WHERE Id
                           IN (Select AandC__c From C__c where Name LIKE 'John%')];
    for(A__c a:achild)
    {
    	for(C__c c:a.C_s__r)
    	{
    	System.debug(c);
    	}
    	System.debug(achild);
    }
	}  
}

//ParenttochildAC pac=new ParenttochildAC();
//pac.records();