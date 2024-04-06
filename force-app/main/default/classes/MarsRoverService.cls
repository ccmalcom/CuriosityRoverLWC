public with sharing class MarsRoverService {
    private static final String API_URL = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos';
    private static final String API_KEY = 'WKjR8Q56dyBeJsYXNbAVqkD9zdw3kXLcUUAat4Cn'; // Consider moving this to a secure location

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getRoverPhotos(String camera, String earthDate) {
        if (earthDate == null || camera == null) {
            earthDate = '2015-6-3'; // Default date
            camera = 'FHAZ'; // Default camera
        }
        
        String requestUrl;
        if (camera == 'All') {
            requestUrl = API_URL + '?earth_date=' + earthDate + '&api_key=' + API_KEY;
        } else {
            requestUrl = API_URL + '?earth_date=' + earthDate + '&camera=' + camera + '&api_key=' + API_KEY;
            
        }
            
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestUrl);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> photosArray = (List<Object>) results.get('photos');
            List<Map<String, Object>> photosList = new List<Map<String, Object>>();
            
            for (Object photoObj : photosArray) {
                Map<String, Object> photoMap = (Map<String, Object>) photoObj;
                // Directly add the map to the list, or make a shallow copy if modification is needed
                photosList.add(photoMap);
            }

            return photosList;
        } else {
            System.debug('The HTTP request failed with status code: ' + response.getStatusCode());
            return null;
        }
    }
}
