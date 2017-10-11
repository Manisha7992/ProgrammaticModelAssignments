public with sharing class ParentToChildAccountContact{
    
    /**Parentchild relationship to print where name is John**/
    public void records()
    {
       List<Account> accountContact=[Select name,id,(Select name,id,email FROM Contacts)
                          FROM Account 
                          WHERE name
                          LIKE '%JOHN%'];                           
         for(Account accountRecord:accountContact)
          {
            for(Contact contactRecord:accountRecord.contacts)
            {
              System.debug(contactRecord);
            }
          System.debug(accountRecord);
         }
     }
     
}