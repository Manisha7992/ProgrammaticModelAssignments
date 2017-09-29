@isTest
global class TestMockGoogleAPI implements HttpCalloutMock {
 //Implement this interface method  
  global HTTPResponse respond(HTTPRequest req) {   
      // Create a fake response
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody('{ "results" : [ { "address_components" : [ { "long_name" : "411021", "short_name" : "411021", "types" : [ "postal_code" ] }, { "long_name" : "Pune", "short_name" : "Pune", "types" : [ "locality", "political" ] }, { "long_name" : "Pune", "short_name" : "Pune", "types" : [ "administrative_area_level_2", "political" ] }, { "long_name" : "Maharashtra", "short_name" : "MH", "types" : [ "administrative_area_level_1", "political" ] }, { "long_name" : "India", "short_name" : "IN", "types" : [ "country", "political" ] } ], "formatted_address" : "Pune, Maharashtra 411021, India", "geometry" : { "bounds" : { "northeast" : { "lat" : 18.563207, "lng" : 73.79860000000001 }, "southwest" : { "lat" : 18.4924043, "lng" : 73.7496996 } }, "location" : { "lat" : 18.5282286, "lng" : 73.7778077 }, "location_type" : "APPROXIMATE", "viewport" : { "northeast" : { "lat" : 18.563207, "lng" : 73.79860000000001 }, "southwest" : { "lat" : 18.4924043, "lng" : 73.7496996 } } }, "place_id" : "ChIJ60Sjh_S-wjsRv9Ob0HI1bb4", "types" : [ "postal_code" ] } ], "status" : "OK" } ');
      res.setStatusCode(200);
      return res;    
    }   
}