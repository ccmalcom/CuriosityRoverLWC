import { LightningElement, api, track } from 'lwc';

export default class RoverDisplay extends LightningElement {
    @api photos;
    @api images;
    @api pages;
    @track isModalOpen = false;
    @track selectedImageUrl;
    @track selectedCameraName;

    currentPage = 1;

    get hasPhotos() {
        return this.photos && this.photos.length > 0;
    }

    get selectedImages() {
        const start = (this.currentPage - 1) * 20;
        const end = this.currentPage * 20;
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
        this.selectedImageUrl = event.target.src; 
        this.selectedCameraName = this.photos.find(photo => photo.img_src === this.selectedImageUrl).camera.full_name;
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }

}
