import { LightningElement } from 'lwc';

export default class RoverSearch extends LightningElement {
    // input form: earth date and camera
    earthDate;
    camera;

    // earth date change event
    handleEarthDateChange(event) {
        this.earthDate = event.target.value;
    }
    // camera change event
    handleCameraChange(event) {
        this.camera = event.target.value;
    }
    
    handleSearch() {
        // Dispatching a custom event with camera and earthDate as details
        const searchEvent = new CustomEvent('search', {
            detail: {
                camera: this.camera,
                earthDate: this.earthDate
            }
        });
        this.dispatchEvent(searchEvent);
    }

}