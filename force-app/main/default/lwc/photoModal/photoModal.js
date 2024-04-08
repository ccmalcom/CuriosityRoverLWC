import { LightningElement, api } from 'lwc';

export default class PhotoModal extends LightningElement {
    @api imageUrl;

    closeModal() {
        this.dispatchEvent(new CustomEvent('close'));
    }
}
