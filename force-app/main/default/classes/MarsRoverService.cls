public with sharing class MarsRoverService {
    private static final String API_URL = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos';
    private static final String API_KEY = 'WKjR8Q56dyBeJsYXNbAVqkD9zdw3kXLcUUAat4Cn';

    @AuraEnabled(cacheable=true)
    public static List<MarsPhoto> getRoverPhotos(String camera, String earthDate) {
        String requestUrl = API_URL + '?earth_date=' + earthDate + '&camera=' + camera + '&api_key=' + API_KEY;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestUrl);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        List<MarsPhoto> photos = new List<MarsPhoto>();

        if (response.getStatusCode() == 200) {
            //parse
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            // Assuming the response contains a list of photos under the 'photos' key
            List<Object> photoList = (List<Object>) results.get('photos');
            for (Object photoObj : photoList) {
                Map<String, Object> photoMap = (Map<String, Object>) photoObj;
                
                // Create a new MarsPhoto object and add it to the list
                MarsPhoto photo = new MarsPhoto();
                photo.id = (Integer) photoMap.get('id');
                photo.imageUrl = (String) photoMap.get('img_src');
                // Add more fields as necessary

                photos.add(photo);
            }
        }

        return photos;
    }

    // Inner class to represent a Mars Rover photo
    public class MarsPhoto {
        public Integer id;
        public String imageUrl;
        // Add more fields as necessary
    }
}
