public with sharing class StarController {
    @AuraEnabled(Cacheable=true)
    public static Contact[] getPersonajes() {

        return[SELECT Id, LastName, height__c, gender__c, hair_color__c,
        eye_color__c, url__c, homeworld__c, number_character__c FROM Contact ORDER BY number_character__c];

    }
        
    @AuraEnabled(Cacheable=true)
    public static Contact[] searchContacts(String searchTerm) {
        // Return all bears when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getPersonajes();
        }
        // Prepare query paramters
        searchTerm = '%' + searchTerm + '%';
        // Execute search query
        return [
            SELECT Id, LastName, height__c, gender__c, hair_color__c,
            eye_color__c, url__c, homeworld__c, number_character__c FROM Contact
            WHERE number_character__c LIKE :searchTerm
            ORDER BY number_character__c ];
    }
/*
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getPeoples(){
        List<Contact> peoples = new List<Contact>();
        string strEndPointURL = 'https://swapi.dev/api/people/';
                
        peoples = getPeoples(strEndPointURL);
        system.debug(peoples.size());
        return peoples;
    }
    
    private static List<Contact> getStarships(string strEndPointURL){
        String strResponse = null;
        if(String.isNotBlank(strEndPointURL)) {
            HttpRequest request = new HttpRequest();
			request.setEndpoint(strEndPointURL);
			request.setMethod('GET');
			request.setHeader('Accept', 'application/json');
            
            try {  
                Http http = new Http();   
				HttpResponse response = http.send(request);
                                
                if (response.getStatusCode() == 200 ) {  
                    strResponse = response.getBody();  
                } 
                else {  
                    throw new CalloutException(response.getBody());  
                }   
            } 
            catch(Exception ex) {  
                throw ex;  
            }  
        } 
        
        if(!String.isBlank(strResponse)) {
            JSON2Apex res = JSON2Apex.parse(strResponse); 
            return res.results;
        } else {
        	return new List<Contact>();
        }        
    }
*/
    }
    
   