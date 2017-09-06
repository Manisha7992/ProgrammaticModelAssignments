public with sharing class Searchclass {
	
   public list <Account> acc {get;set;}
   public list<Contact> con{get;set;}
   public list<Lead> lea{get;set;}
   public list<Opportunity> opty{get;set;}
   public string searchstring {get;set;} 
   public string value1 {get;set;} 
      
   public Searchclass(ApexPages.StandardController controller) {     
   }  
   
   public void search(){  
		if(searchstring != null && searchstring != '' ){  
		string searchquery='select Name, Phone from Account where Name like \'%'+searchstring+'%\'  Limit 10';  
		string searchquery1='select Name, Phone from Contact where Name like \'%'+searchstring+'%\'  Limit 10';
		string searchquery2='select Name, Phone from Lead where Name like \'%'+searchstring+'%\'  Limit 10';
		string searchquery3='select Name, StageName from Opportunity where Name like \'%'+searchstring+'%\'  Limit 10';
		acc= Database.query(searchquery); 
		con= Database.query(searchquery1); 
		lea= Database.query(searchquery2);
		opty= Database.query(searchquery3); 
     }
    }
      
      public void searchsosl()
      {
		List<List<SObject>> searchList = [FIND :searchstring IN Name FIELDS RETURNING                                      
                                                Account(Id, Name),
                                                 Contact(Id, Name),
                                                Lead(Id,Name),
                                                Opportunity(Id,Name)];                                              
		acc= (Account[])searchList[0];
		con = (Contact[])searchList[1];
		lea= (Lead[])searchList[2];
		opty= (Opportunity[])searchList[3];
      }
	  
     }