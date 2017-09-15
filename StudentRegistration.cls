public with sharing class StudentRegistration {
    public  StudentDetail__c student   {get;set;}
    public List<SelectOption> langList {get;set;}
    public String selectedLang         {get;set;}
    public String languageCode         {get;set;}
    
    public StudentRegistration(ApexPages.StandardController controller)
    {
        student =(StudentDetail__c)controller.getRecord();
        langList = new  List<SelectOption>();
        if(Language__c.getAll().values().size()> 0)   
        {
           for(Language__c setting : Language__c.getAll().values())
           {
               langList.add(new SelectOption(setting.Name, setting.Name));
           }
           selectedLang = Language__c.getAll().values()[0].Name;
           languageCode = Language__c.getAll().values()[0].Language_Code__c;
           //languageCOde = 'es';
        }
    }
    
    public void selectChange()
    {    	
        for(Language__c setting : Language__c.getAll().values())
        {
            if(setting.Name==selectedLang)
            {
              System.debug('Language found in custom setting');  
              languageCode = setting.Language_Code__c;           
            }
        }
    }
    
    public pagereference save()
    {
        insert student;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Record created'));
        return null;
    }
    
}