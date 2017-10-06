public with sharing class BusBooking {

public List<SelectOption> stops{get;set;}
public String selectedstops{get;set;}
public Account acc{get;set;}
public  List<Route_Stop__c> lstroutestop{get; set;}
public Integer nooftickets{get;set;}
public List<SelectOption> capacitylist{get;set;}
Vehicle_Route__c vehroute{get;set;}
public String recid{get;set;}
public Double doubcapacity{get;set;}
public boolean availablesection{get;set;}
public boolean notavailablesection{get;set;}
public Double doub{get; set;}

 
   public BusBooking(ApexPages.StandardController controller) { 
     acc =(Account)controller.getRecord();
     lstroutestop= new List<Route_Stop__c>();  
     getTicketslist();
     availablesection =false;
     }  
    
   
 /** List to display the number of tickets**/
   public List<SelectOption> getTicketslist() {
    capacitylist = new List<SelectOption>();
    capacitylist.add(new SelectOption('0','0'));
    capacitylist.add(new SelectOption('1','1'));
    capacitylist.add(new SelectOption('2','2'));
    capacitylist.add(new SelectOption('3','3'));
    capacitylist.add(new SelectOption('4','4'));
    capacitylist.add(new SelectOption('5','5'));
    capacitylist.add(new SelectOption('6','6'));
    capacitylist.add(new SelectOption('7','7'));
    capacitylist.add(new SelectOption('8','8'));
    capacitylist.add(new SelectOption('9','9'));
    capacitylist.add(new SelectOption('10','10'));
    return capacitylist;
   }
   
   
   /** List to display the schoolstops**/
    public List<SelectOption> getStopList() {
     stops= new List<SelectOption>();
     stops.add(new SelectOption('None','None'));
     stops.add(new SelectOption('Symbiosis School', 'Symbiosis School')); 
     stops.add(new SelectOption('DAV School', 'DAV School'));
     stops.add(new SelectOption('Army Public School', 'Army Public School')) ;  
     return stops;  
      } 
      
     
    /** Get routes method to display the routes based on google api**/    
     public void getroutes(){
       HttpRequest req = new HttpRequest();
       Http http = new Http();
       req.setMethod('GET');
       String url='https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyA0vqKj6rA67xgzWviPdr6GknQsy-WUWmM&address='+acc.BillingPostalCode+'&sensor=false';  
       req.setEndPoint(url);
       HTTPResponse resp = http.send(req);       
       JSONParser parser = JSON.createParser(resp.getBody()); //Json parser to parse the json string obtained from url
       Double latitude = null;
       Double longitude = null;
       while (parser.nextToken() != null)
       {
       if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)  && (parser.getText() == 'location'))
       {
       // Jump to latitude and longtitude fields.
       parser.nextToken();
       while (parser.nextToken() != JSONToken.END_OBJECT)
       {
       String text = parser.getText();
       parser.nextToken();
       if (text == 'lat') latitude = parser.getDoubleValue();
       else if (text == 'lng') longitude = parser.getDoubleValue();
          }
          } 
          }
       String query = 'SELECT School__c FROM Stop__c WHERE';
       query+= ' DISTANCE(Location__c, GEOLOCATION('+latitude+','+longitude+'),\'mi\') < 10 ';
       query+='ORDER BY DISTANCE(Location__c, GEOLOCATION('+latitude+','+longitude+'),\'mi\') LIMIT 3';       
       if(latitude != null && longitude!= null){
       List<Stop__c> stoplist = Database.query(query);            
       Set<id> setstopid = new Set<Id>();             
       for(Stop__C obj:stoplist){
       setstopid.add(obj.id);
          }             
       lstroutestop=[SELECT Route__c,Route__r.name,Stop__r.name,Route__r.From__c,Route__r.To__c FROM Route_Stop__c where Stop__c in :setstopid ];
       for(integer i=0;i<lstroutestop.size();i++){
           if(lstroutestop.get(i).Stop__r.name != selectedstops)
               lstroutestop.remove(i);
       }     
          }                    
         }
           
             
     /** Get availability method to display the availability of seats**/  
      public void getavailability(){
        System.debug('rcordid'+recid);
        Vehicle__c vehicleobj = new Vehicle__c();
        vehroute=[SELECT VehicleJunction__r.name,VehicleJunction__r.Capacity__c,VehicleJunction__c,RouteJunction__r.name,RouteJunction__c FROM Vehicle_Route__c WHERE   RouteJunction__c= :recid limit 1 ];
        vehicleobj =[Select Capacity__c from Vehicle__c where id= :vehroute.VehicleJunction__c];
        System.debug('vehicle list value is'+vehicleobj);                                  
        doub = vehicleobj.Capacity__c;
        System.debug('doub value is'+doub);
        doubcapacity =doub - nooftickets;
        vehicleobj.Capacity__c = doubcapacity;
        System.debug('new capacity value is'+doubcapacity);
        if(doubcapacity >0)
         {
           availablesection=true;   
           notavailablesection=false;
         }
         else
         {
           notavailablesection=true;    
           availablesection=false;
          }               
         }
              
              
       /** Gotobookingpage method to redirect the user to the booking page**/     
       public PageReference gotoBookingpage(){
         PageReference pr = Page.BookingPage;
         pr.setRedirect(true);
         pr.getParameters().put('routeid',vehroute.RouteJunction__c);
         string s1=string.valueof(nooftickets);
         pr.getParameters().put('numoftickets',s1);
         string s2=string.valueof(doubcapacity);                    
         pr.getParameters().put('capacity',s2);
         pr.getParameters().put('vehicleid',vehroute.VehicleJunction__c);
         return pr;                                     
          }    
}


//411021r1
///411014r2
//411001r3