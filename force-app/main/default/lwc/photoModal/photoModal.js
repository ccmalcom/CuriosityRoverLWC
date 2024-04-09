import { LightningElement, api } from 'lwc';

export default class PhotoModal extends LightningElement {
    @api imageUrl;
    @api cameraName;

    clickHandler(event) {
        let dispatcher = event.target.id;

        if (dispatcher.includes('modal-section') || dispatcher.includes('modal-container')) {
            console.log('closing modal');
            this.closeModal();
            this.stopPropagation(event);
        }
        event.stopPropagation();
    }

    closeModal() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    openImageInNewTab() {
        window.open(this.imageUrl, '_blank');
    }
}
