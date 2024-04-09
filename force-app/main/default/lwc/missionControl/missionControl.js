import { LightningElement } from 'lwc';
import getRoverPhotos from '@salesforce/apex/MarsRoverService.getRoverPhotos';

export default class MissionControl extends LightningElement {
    roverPhotos = [];
    totalImages = 0;
    totalPages = 1;
    loading = false;

    handleSearch(event) {
        // this.roverPhotos = [];
        this.loading = true;
        console.log('MissionControl received search event:', event.detail.camera, event.detail.earthDate);
        const { camera, earthDate } = event.detail;
        getRoverPhotos({ camera: camera, earthDate: earthDate })
            .then(result => {
                console.log('Mars Rover photos:', result);
                if (result.length > 0) {
                    this.totalImages = result.length;
                    this.totalPages = Math.ceil(this.totalImages / 25);
                    this.roverPhotos = result;
                } else {
                    this.roverPhotos = 'none'; // No photos found
                }
            })
            .catch(error => {
                console.error('Error fetching Mars Rover photos:', error.message);
                this.roverPhotos = null; // No photos found or error occurred
            })
            .finally(() => {
                this.loading = false;
            });
    }
}
