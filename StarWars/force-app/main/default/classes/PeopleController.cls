public inherited sharing class PeopleController {
    
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getPeople(){
        List<Contact> people = new List<Contact>();
        string strEndPointURL = 'https://swapi.dev/api/people/';
                
        people = getPeople(strEndPointURL);
        system.debug(people.size());
        return people;
    }
    
    private static List<Contact> getPeople(string strEndPointURL){
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
            return res.Results;
        } else {
        	return new List<Contact>();
        }        
    }

}
