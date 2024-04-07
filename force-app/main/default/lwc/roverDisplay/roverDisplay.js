import { LightningElement, api } from 'lwc';

export default class RoverDisplay extends LightningElement {
    @api photos;
    @api images;
    @api pages;

    currentPage = 1;

    get hasPhotos() {
        return this.photos && this.photos.length > 0;
    }

    get selectedImages() {
        const start = (this.currentPage - 1) * 25;
        const end = this.currentPage * 25;
        return this.photos.slice(start, end);
    }

    handlePrev() {
        if (this.currentPage > 1) {
            this.currentPage -= 1;
        }
    }

    handleNext() {
        if (this.currentPage < this.pages) {
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
