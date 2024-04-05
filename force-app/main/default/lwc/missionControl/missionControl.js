import { LightningElement } from 'lwc';
import getRoverPhotos from '@salesforce/apex/MarsRoverService.getRoverPhotos';

export default class MissionControl extends LightningElement {
    roverPhotos = [];

    handleSearch(event) {
        const { camera, earthDate } = event.detail;
        getRoverPhotos({ camera: camera, earthDate: earthDate })
            .then(result => {
                console.log('Mars Rover photos:', result);
                console.log('first photo:', result[0]);
                console.log('first photo img:', result[0].imgUrl);
                this.roverPhotos = result;
            })
            .catch(error => {
                console.error('Error fetching Mars Rover photos:', error);
            });
    }
}
