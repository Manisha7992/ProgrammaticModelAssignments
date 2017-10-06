public with sharing class CalloutUtility {
	
public static HTTPResponse googleApiCallout(Account accountRecord)
{
   HttpRequest req = new HttpRequest();
   Http http = new Http();
   req.setMethod('GET');
   String url='https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyA0vqKj6rA67xgzWviPdr6GknQsy-WUWmM&address='+accountRecord.BillingPostalCode+'&sensor=false';
   req.setEndPoint(url);
   HTTPResponse resp = http.send(req);
   return resp;
}
    
}