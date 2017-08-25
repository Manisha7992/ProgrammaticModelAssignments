public with sharing class Parentjunction {
	
//ParenttoChild from A,B and C
	public void parentchildrecords(){
		List<C__c> child=[SELECT AandC__r.id,AandC__r.name,BandC__r.id,BandC__r.name,Name,ID FROM C__c];
		System.debug(' A,B,CRecords are:'+child)	;	
	}
	
    
}

//Parentjunction pj=new Parentjunction();
//pj.parentchildrecords();