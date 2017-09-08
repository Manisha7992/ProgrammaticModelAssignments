public with sharing class CountryCityPicker {
    
// Variables to store country and state selected by user
    public String city { get; set; }
    public String country {get; set;}
    public List<SelectOption> optionscity{get;set;}
    public List<SelectOption> optionscountry{get;set;}
     

    // Generates country dropdown from country settings
    public List<SelectOption> getCountriesSelectList() {
        optionscountry = new List<SelectOption>();
        optionscountry.add(new SelectOption('', '-- Select One --'));        

        // Find all the countries 
        Map<String, Country__c> countries = Country__c.getAll();
        
        // Add the countries to list and sort them
        List<String> countryNames = new List<String>();
        countryNames.addAll(countries.keySet());
        countryNames.sort();
        
        // Create the Select Options.
        for (String countryName : countryNames) {
           Country__c country = countries.get(countryName);
          
            optionscountry.add(new SelectOption(country.Name, country.Name));
            System.debug(optionscountry);
        }
        
        System.debug(optionscountry);
        return optionscountry;
    }
    
    
    //Generates City Dropdown
    public List<SelectOption> getCitiesSelectList() {
    optionscity=new List<SelectOption>();
     
     //Find all cities 
     Map<String,City__c> allcities=City__c.getAll();
     
     //Filter cities belonging to that country
      Map<String,City__c> newcities= new Map<String,City__c>();
      for(City__c cities:allcities.values())
      {
        if(cities.Country__c == this.country)
        {
            //cities.put(cities.name,cities.name);
            newcities.put(cities.name,cities);
      }
      }
      
     //List to get all the cities and sort them
       List<String> cityNames = new List<String>();
       //cityNames.addAll(allcities.keySet());
       cityNames.addAll(newcities.keySet());
       cityNames.sort();
      
      //Generating select options 
     for(String cityName:cityNames)
     {
       City__c city=newcities.get(cityName);
       optionscity.add(new SelectOption(city.name, city.name));
     }
     
     //if no cities are found then say required missing
     if(optionscity.size()>0)
     {
        optionscity.add(0,new SelectOption('','--Select City--'));
     }
     else
     {
        optionscity.add(new SelectOption('','-Required missing--'));
     }    
      return optionscity;
    }
    
}