public with sharing class BusBookingExtension {

    public List<SelectOption> stopsList{get;set;}
    public String schoolStops{get;set;}
    public Account accountRecord{get;set;}
    public  List<Route_Stop__c> routeStopList{get; set;}
    public Integer noOfTickets{get;set;}
    public List<SelectOption> capacityList{get;set;}
    Vehicle_Route__c vehicleRouteRecord{get;set;}
    public String recordId{get;set;}
    public Double capacityValue{get;set;}
    public List<SelectOption> optionsStops{get;set;}

   public BusBookingExtension (ApexPages.StandardController controller) 
    { 
      accountRecord =(Account)controller.getRecord();
      routeStopList= new List<Route_Stop__c>();  
      getTicketsList();
    }  
    
   
  /** List to display the number of tickets**/
   public List<SelectOption> getTicketsList() 
   {
     capacityList = new List<SelectOption>();  
       for(Integer count=0; count<=10; count++)
       {
        String capacityString = String.valueOf(count);
        capacityList.add(new SelectOption(capacityString , capacityString));   
       }
     return capacityList;
   }
   
     
    /** List to display school stops from country settings **/
    public List<SelectOption> getSchoolStopsSelectList() 
    {
      optionsStops = new List<SelectOption>();
      optionsStops.add(new SelectOption('', '-- Select One --')); 
                         
      Map<String, SchoolStops__c> stops = SchoolStops__c.getAll(); 
             
      List<String> stopNames = new List<String>();
      stopNames.addAll(stops.keySet());
      stopNames.sort();      
       for (String stopName : stopNames) 
       {
         SchoolStops__c schoolStops = stops.get(stopName);
         optionsStops.add(new SelectOption(schoolStops.Name,schoolStops.Name));         
       }               
      return optionsStops;
    }
      
     
    /** Get routes method to display the routes based on google api**/    
    public void getRoutes()
     {  
       CalloutUtility.googleApiCallout(accountRecord);            //GoogleAPI CalloutUtility class    
       HTTPResponse resp =CalloutUtility.googleApiCallout(accountRecord);       
       JSONParser parser = JSON.createParser(resp.getBody());     //Json parser to parse the json string obtained from url
       Double latitude = null; 
       Double longitude = null;
       while (parser.nextToken() != null)
        {
         if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)  && (parser.getText() == 'location'))
          {      
            parser.nextToken();                                     // Iterates over latitude and longtitude fields.
            while (parser.nextToken() != JSONToken.END_OBJECT)
             {
               String text = parser.getText();
               parser.nextToken();
               if (text == 'lat') 
                {
                  latitude = parser.getDoubleValue();
                }
               else if (text == 'lng')
                {
                  longitude = parser.getDoubleValue();
                }
               }
             } 
          }
       String query = 'SELECT School__c FROM Stop__c WHERE';
       query+= ' DISTANCE(Location__c, GEOLOCATION('+latitude+','+longitude+'),\'mi\') < 10 ';
       query+='ORDER BY DISTANCE(Location__c, GEOLOCATION('+latitude+','+longitude+'),\'mi\') LIMIT 3';       
       if(latitude != null && longitude!= null)
       {
         List<Stop__c> stopList = Database.query(query);            
         Map<Id, Stop__c> stopsMap =new Map<Id, Stop__c>(stopList);                         
         routeStopList=[SELECT Route__c,Route__r.name,Stop__r.name,Route__r.From__c,Route__r.To__c 
                       FROM Route_Stop__c 
                       WHERE Stop__c in :stopsMap.keySet()
                       AND Stop__r.name =: schoolStops ];
          }    
          else
          {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Enter valid postal code')); //Error message for invalid postal code
          }                
        }
           
             
     /** Get availability method to display the availability of seats**/  
      public Pagereference getAvailability()
      {        
        Vehicle__c vehicleObject = new Vehicle__c();
        vehicleRouteRecord = [SELECT VehicleJunction__r.name,VehicleJunction__r.Capacity__c,VehicleJunction__c,RouteJunction__r.name,RouteJunction__c 
                            FROM Vehicle_Route__c 
                            WHERE   RouteJunction__c= :recordId limit 1 ];
        vehicleObject = [Select Capacity__c 
                        FROM Vehicle__c 
                        WHERE id= :vehicleRouteRecord.VehicleJunction__c];                                       
        capacityValue = vehicleObject.Capacity__c - noOfTickets;
        vehicleObject.Capacity__c = capacityValue;
        PageReference pr = gotoBookingPage();
        return pr;                       
      }
              
              
       /** Gotobookingpage method to redirect the user to the booking page**/     
       public PageReference gotoBookingPage()
       {
         PageReference pr = Page.BookingPage;
         pr.setRedirect(true);
         pr.getParameters().put('routeid',vehicleRouteRecord.RouteJunction__c);
         string s1=string.valueof(noOfTickets);
         pr.getParameters().put('numberoftickets',s1);
         string s2=string.valueof(capacityValue);                    
         pr.getParameters().put('capacity',s2);
         pr.getParameters().put('vehicleid',vehicleRouteRecord.VehicleJunction__c);
         return pr;                                             
       }    
   }