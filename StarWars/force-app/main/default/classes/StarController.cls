public with sharing class StarController {
    @AuraEnabled(Cacheable=true)
    public static Contact[] getPersonajes() {

        return[SELECT Id, LastName, height__c, gender__c, hair_color__c,
        eye_color__c, url__c, homeworld__c, number_character__c FROM Contact];

    }
}
