import { LightningElement } from 'lwc';
import getRoverPhotos from '@salesforce/apex/MarsRoverService.getRoverPhotos';

export default class MissionControl extends LightningElement {
    roverPhotos = [];

    handleSearch(event) {
        console.log('MissionControl received search event:', event.detail.camera, event.detail.earthDate);
        const { camera, earthDate } = event.detail;
        getRoverPhotos({ camera: camera, earthDate: earthDate })
            .then(result => {
                console.log('Mars Rover photos:', result);
                console.log('first photo:', result[0]);
                console.log('first photo img:', result[0].img_src);
                this.roverPhotos = result.length > 0 ? result : null;
            })
            .catch(error => {
                console.error('Error fetching Mars Rover photos:', error.message);
                this.roverPhotos = null; // No photos found or error occurred
            });
    }
}
