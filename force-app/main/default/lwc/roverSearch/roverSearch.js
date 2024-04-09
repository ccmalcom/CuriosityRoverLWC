import { LightningElement, track } from 'lwc';
import roverSprite from '@salesforce/resourceUrl/roverSprite';


export default class RoverSearch extends LightningElement {
    @track selectedCamera = 'All';
    @track inputDate;

    sprite = roverSprite;

    get cameraOptions() {
        return [
            { label: 'All', value: 'All' },
            { label: 'FHAZ (Front Hazard Avoidance Camera)', value: 'fhaz' },
            { label: 'RHAZ (Rear Hazard Avoidance Camera)', value: 'rhaz' },
            { label: 'MAST (Mast Camera)', value: 'mast' },
            { label: 'CHEMCAM (Chemistry and Camera Complex)', value: 'chemcam' },
            { label: 'MAHLI (Mars Hand Lens Imager)', value: 'mahli' },
            { label: 'MARDI (Mars Descent Imager)', value: 'mardi' },
            { label: 'NAVCAM (Navigation Camera)', value: 'navcam' },
            { label: 'PANCAM (Panoramic Camera)', value: 'pancam' },
            { label: 'MINITES (Miniature Thermal Emission Spectrometer (Mini-TES))', value: 'minites' }
        ];
    }

    get maxDate() {
        const today = new Date();
        const year = today.getFullYear();
        let month = today.getMonth() + 1;
        let day = today.getDate() - 1;
        if (month < 10) {
            month = '0' + month;
        }
        if (day < 10) {
            day = '0' + day;
        }
        return year + '-' + month + '-' + day;
    }

    handleCameraChange(event) {
        this.selectedCamera = event.detail.value;
    }
    handleDateChange(event) {
        this.inputDate = event.target.value;
    }

    handleSubmit(event) {
        event.preventDefault();
        const searchEvent = new CustomEvent('search', {
            detail: {
                camera: this.selectedCamera,
                earthDate: this.inputDate
            }
        });
        // Dispatch the event to the parent component
        this.dispatchEvent(searchEvent);

    }
}
