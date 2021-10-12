import { LightningElement, wire } from 'lwc';

import getPeople from '@salesforce/apex/PeopleController.getPeople';

export default class PeopleViewer extends LightningElement {
    people;
	error;

    connectedCallback(){
        getPeople()
			.then(result => {
				this.people = result;
			})
			.catch(error => {
				this.error = error;
			});
    }
}