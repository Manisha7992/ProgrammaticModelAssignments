public with sharing class AccountSearchClass {
  
   public list <Account> acc {get;set;}
   public string searchstring {get;set;} 
   public string value1 {get;set;}
   public Integer Length{get;set;}
   public Id recid{get; set;}
   public List<Contact> lstcon{get;set;}
   public List<Contact> Showcon{get;set;}
   public List<String> SearchAlphabet{get;set;}
   public String SearchVar{get;set;}
   
   public AccountSearchClass(ApexPages.StandardController controller) {    
   }  
   
   public void searchsosl(){     
     if(searchstring!=null && searchstring.length() >= 3)
                {
                    if(lstcon != null)
                   lstcon.clear();
                   if(Showcon != null)
                   Showcon.clear();   
      List<List<SObject>> searchList = [FIND :searchstring IN Name FIELDS RETURNING                                      
                                                Account(Id, Name)];
      acc= (Account[])searchList[0];
      Length=acc.size();
      if(Length == 0)
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Accounts Found')); 
     }     
     else if(searchstring.length() <= 3)
     {
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter atleast 3 characters'));
     }  
}

public void clear(){
   if(acc != null){
       acc.clear();
           if(lstcon != null)
           lstcon.clear();
           if(Showcon != null)
           Showcon.clear();
   }
}

public void getcontactdetails(){
  lstcon = [Select name from Contact where accountid=:recid];  
  SearchAlphabet=new List<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
  if(String.isBlank(SearchVar)){
      SearchVar='All';
  }    
  ShowCon=new List<Contact>();
  for(Contact c:lstcon)
    {
    if(SearchVar.equals('All'))
        ShowCon.add(c);
    else 
      if(c.Name.startsWith(SearchVar.toLowerCase())||c.Name.startsWith(SearchVar))
        ShowCon.add(c);       
    }
}

public PageReference display() 
  {  
    ShowCon.clear();
    for(Contact c:lstcon)
    {
      if(SearchVar.equals('All'))
        ShowCon.add(c);
        else
        if(c.Name.startsWith(SearchVar.toLowerCase())||c.Name.startsWith(SearchVar))
        {
           ShowCon.add(c);
           system.debug('_______________if ______C__________________'+c);
        }     
    }  
    return null;
  }
  
@RemoteAction
        public static void deleteCon(Id C)
        {
          Contact delcon=new Contact();
            delcon=[Select ID from Contact where Id=:C];
            delete delcon;
        }
}