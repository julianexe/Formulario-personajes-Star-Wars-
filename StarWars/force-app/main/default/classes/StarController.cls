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
    }
    
   