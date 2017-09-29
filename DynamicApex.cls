public class DynamicApex {
	
	public List<SelectOption> objects {set;get;}
    public List<SelectOption> fsoptions{set;get;}
    public List<SelectOption> fnsoptions{set;get;}
    public String selectedObj {set;get;}
    public List<String> objlst {set;get;}
    public List<String> fields{set;get;}
    public Set<String> fselected{set;get;}
    public List<String> myFields{set;get;}
    public Set<string> fnotselected{set;get;}
    public Map<String, Schema.SObjectField> mfields{set;get;}
    public Map<String, Schema.SObjectType> mobjects{set;get;}
    public String objDescription {set;get;}
    public List<String> sfields{set;get;}
    public List<String> rfields{set;get;}
    public String query{set;get;}
    public List<SObject> mydata{set;get;}
    public List<List<SObject>> mylist{set;get;}
    public Boolean isObjSelected{set;get;}
    public Boolean isQueryExecuted{set;get;}
    public List<SelectOption> limitOptions {set;get;}
    public String selectedLimit {set;get;}
    public String selectedOrder{set;get;}
    public List<SelectOption> orderOptions{set;get;}
    public String searchString{set;get;}
    
       
    public DynamicApex() //Constructor
    {
        isObjSelected = false;
        isQueryExecuted = false;
        limitOptions = new List<SelectOption>();
        orderOptions = new List<SelectOption>();
        objects = new List<SelectOption>();
        myFields = new List<String>();
        objlst = new List<String>();
        mydata = new List<SObject>();
        sfields = new List<String>();
        rfields = new List<String>();
        fields = new List<String>();
        fselected = new Set<String>();
        fnotselected = new Set<String>();
        fsoptions = new List<SelectOption>();
        fnsoptions = new List<SelectOption>();
        mobjects = Schema.getGlobalDescribe();
        for(Schema.SObjectType objToken : mobjects.values())
        {
            Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();
            if (objDescribe.isAccessible() && objDescribe.isQueryable()){
                objlst.add(objDescribe.getName());
            }
        }
        //objlst.addAll(mobjects.keySet());
        objlst.sort();
        SelectOption none = new SelectOption('None','-None-');
        objects.add(none);
        for(String s : objlst)
        {
            SelectOption option = new SelectOption(s,s);
            objects.add(option);
        }
        limitOptions.add(new SelectOption('500','500'));
        limitOptions.add(new SelectOption('1000','1000'));
        limitOptions.add(new SelectOption('5000','5000'));
        limitOptions.add(new SelectOption('50000','50000'));
        selectedLimit = '500';
        orderOptions.add(new SelectOption('ASC','Ascending'));
        orderOptions.add(new SelectOption('DESC','Descending'));
        selectedOrder = 'ASC';
    }
    
    /*
* Method to select object from picklist and populated fields section with fields available in that object
*/
    public void details(){
        isQueryExecuted = false;
        query = '';
        if(selectedObj != 'None')
        {
            Schema.DescribeSObjectResult myObj = mobjects.get(selectedObj).getDescribe();
            objDescription = ' '+myObj;
            mfields = mobjects.get(selectedObj).getDescribe().fields.getMap();
            fields.clear();
            for(Schema.SObjectField fieldToken : mfields.values())
            {
                Schema.DescribeFieldResult fieldDescribe = fieldToken.getDescribe();
                if(fieldDescribe.isAccessible())
                {
                    fields.add(fieldDescribe.getName());
                }
            }
            //fields.addAll(mfields.keySet());
            fields.sort();
            fnotselected.clear();
            fselected.clear();
            fnotselected.addAll(fields);
            isObjSelected = true;
            show();
        } 
        else
        {
            isObjSelected = false;
        }
    }
    
 /*
* Method to show and add fields from picklistbar as per the selected object and selected fields
*/
    public void show()
    {
        fnsoptions.clear();
        fsoptions.clear();
        System.debug('Inside Show ::: fnotselected:::'+fnotselected);
        System.debug('Inside Show ::: fnsoptions:::'+fnsoptions);
        for(String s : fnotselected)
        {
            SelectOption op = new SelectOption(s,s);
            fnsoptions.add(op);
        }
        System.debug('After Show ::: fnsoptions:::'+fnsoptions);
        for(String s : fselected)
        {
            SelectOption op = new SelectOption(s,s);
            fsoptions.add(op);
        }
    }
    
/*
* Method to add fields from fields picklistbar as per the selected object and selected fields
*/
    public void addFields(){
        fnotselected.removeAll(sfields);
        fselected.addAll(sfields);
        show();
    }
    
/*
* Method to remove fields from fields picklists as per the selected object and selected fields
*/
    public void removeFields(){
        //System.debug('fnotselected:::'+fnotselected);
        System.debug('Rfields:::'+rfields);
        fnotselected.addAll(rfields);
        System.debug('fnotselected:::'+fnotselected);
        fselected.removeAll(rfields);
        show();
    }
    
        
/*
* Method to build and execute the query based on criteria selected by user
*/
    public void queryData(){
        myFields.clear();
        myFields.addAll(fselected);
        myFields.add('Id');
       // query = 'SELECT ';
        //query += String.join(myFields, ',');
        //query += ' FROM '+ selectedObj +' ORDER BY Id '+selectedOrder+' LIMIT '+ selectedLimit;
         query = 'FIND \'';
         query += searchString +'\'';
         query += 'IN ALL FIELDS RETURNING ' + selectedObj + '('+String.join(myFields, ',')+ ' ORDER BY Id '+ selectedOrder+')' + 'LIMIT ' + selectedLimit;
         system.debug('querystring@@@@@@@@@@'+query );
        if(myFields.size()>1)
        {
            try{
               // mydata = Database.query(query);
                myList = search.query(query);
                mydata = myList[0];
                //if(mydata.size()<1){
                if(mydata.size()<1){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No records to find for query'));
                }
                isQueryExecuted = true;
               }
               catch(Exception e)
               {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
               }
        } 
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select few fields to query'));
        }
        System.debug('query is:::'+query);
        System.debug('List is:::'+myList);
    }
      
}