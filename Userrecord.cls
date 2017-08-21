public with sharing class Userrecord {
 
 public void activeUser(){
 	Map<Id,User> mapUser =new Map<Id,User>([Select name,city,email,phone from User where isactive = true]);
 	System.debug('Active user are as follows');
 	for(User u:mapUser.values()){
 		System.debug(u);
 		
 	}
 	
 }
    
    
}