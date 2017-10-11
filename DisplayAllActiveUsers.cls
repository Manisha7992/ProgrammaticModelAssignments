public with sharing class DisplayAllActiveUsers{

/**Method to display the active user records**/
 public void activeUser()
  {
    List<User> userList=[Select name,city,email,phone 
                         FROM User 
                         WHERE isactive = true];
    Map<Id,User> mapUser =new Map<Id,User>();
    for(User userRecord:userList)
    {
       mapUser.put(userRecord.Id,userRecord);   
    }   
    System.debug('Active user are as follows');
    for(User userRecordValue:mapUser.values())
    {
       System.debug(userRecordValue);           
    }   
  }
  
}