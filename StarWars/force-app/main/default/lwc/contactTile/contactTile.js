import { LightningElement, api } from 'lwc';

export default class ContactTile extends LightningElement {
	@api contact;
	
    handleOpenRecordClick() {
        const selectEvent = new CustomEvent('contactview', {
            detail: this.contact.Id
        });
        this.dispatchEvent(selectEvent);
    }
}