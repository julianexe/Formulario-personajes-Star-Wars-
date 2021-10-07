import { LightningElement, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getPersonajes from '@salesforce/apex/StarController.getPersonajes'
import NUMBER_FIELD from '@salesforce/schema/Contact.number_character__c';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
import HEIGHT_FIELD from '@salesforce/schema/Contact.height__c';
import GENDER_FIELD from '@salesforce/schema/Contact.gender__c';
import HAIR_FIELD from '@salesforce/schema/Contact.hair_color__c';
import EYE_FIELD from '@salesforce/schema/Contact.eye_color__c';
import URL_FIELD from '@salesforce/schema/Contact.url__c';
import HOME_FIELD from '@salesforce/schema/Contact.homeworld__c';


 
export default class lwcContact extends LightningElement {
 
    contactColumns = [

        { label: 'Number Character', fieldName: 'number_character__c' },
        { label: 'Name', fieldName: 'LastName' },
        { label: 'Height', fieldName: 'height__c' },
        { label: 'Gender', fieldName: 'gender__c' },
        { label: 'Hair Color', fieldName: 'hair_color__c' },
        { label: 'Eye Color', fieldName: 'eye_color__c' },
        { label: 'URL', fieldName: 'url__c' },
        { label: 'Home World', fieldName: 'homeworld__c' },
        
    ];
 
    fields = [NAME_FIELD, HEIGHT_FIELD, GENDER_FIELD, HAIR_FIELD, EYE_FIELD, URL_FIELD, HOME_FIELD, NUMBER_FIELD];
 
    @wire(getPersonajes)
    contacts;
 
    @api objectApiName;
 
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Character Created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
 
handleSearchId(event){

    console.log(event.detail.value);
    fetch("https://swapi.co/api/people/1/",{headers: {
        'Content-Type': 'application/json','Content-Security-Policy': 'connect-src "self" https://swapi.co'
      },}).then((response)=>{
        console.log(response);
    })
 

}

}
