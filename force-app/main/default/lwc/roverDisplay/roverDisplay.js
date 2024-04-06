import { LightningElement, api } from 'lwc';

export default class RoverDisplay extends LightningElement {
    @api photos;
    totalImages = 0; 
    currentPage = 1; 
    totalPages = 1; 

    get hasPhotos() {
        return this.photos && this.photos.length > 0;
    }

    handlePrev() {
        if (this.currentPage > 1) {
            this.currentPage -= 1;
        }
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage += 1;
        }
    }

    handleImageClick(event) {
        const imgIndex = event.target.dataset.index;
        const selectedEvent = new CustomEvent('selected', {
            detail: this.photos[imgIndex]
        });
        this.dispatchEvent(selectedEvent);
    }

}
