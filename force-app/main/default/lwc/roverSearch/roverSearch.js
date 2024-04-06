import { LightningElement, track } from 'lwc';

export default class RoverSearch extends LightningElement {
    @track selectedCamera = 'All';
    @track inputDate;

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
