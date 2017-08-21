public with sharing class AccountMap {
    
    public void Acckey()
    {
    List<Account> lstacc=[Select name,id from Account];
    Map<String,Id> acckey=new Map<String,Id>();
    for(Account acc: lstacc){
    	acckey.put(acc.name,acc.id);
    	System.debug(acckey);  	
    }
    
    /*for(String key : acckey.keySet()){
    	System.debug(acckey.get(key));
    }*/
    
    //for(Id i :acckey.values()){
    //	System.debug(i);
    //}
    }
  public void record()
    {
        Map<Id,Account> myMapaccount = new Map<Id , Account>();
        
        for( Account accInstance : [select id,name,billingcity from Account])
        {
            myMapaccount.put(accInstance.Id , accInstance);
            System.debug(myMapaccount);
        }
    }    
}