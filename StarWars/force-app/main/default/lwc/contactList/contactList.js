import { publish, MessageContext } from 'lightning/messageService';
import CONTACT_LIST_UPDATE_MESSAGE from '@salesforce/messageChannel/ContactListUpdate__c';
import { NavigationMixin } from 'lightning/navigation';
import { LightningElement, wire } from 'lwc';
/** BearController.searchBears(searchTerm) Apex method */
import searchContacts from '@salesforce/apex/StarController.searchContacts';
export default class contactList extends NavigationMixin(LightningElement) {
	searchTerm = '';
	contacts;
@wire(MessageContext) messageContext;
@wire(searchContacts, {searchTerm: '$searchTerm'})
loadContacts(result) {
  this.contacts = result;
  if (result.data) {
    const message = {
      contacts: result.data
    };
    publish(this.messageContext, CONTACT_LIST_UPDATE_MESSAGE, message);
  }
}
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.contacts.data.length > 0);
	}
	handleContactView(event) {
		// Get bear record id from bearview event
		const contactId = event.detail;
		// Navigate to bear record page
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: contactId,
				objectApiName: 'Contact',
				actionName: 'view',
			},
		});
	}
}