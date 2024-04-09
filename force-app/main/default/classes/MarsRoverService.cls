public with sharing class MarsRoverService {

    private static String apiKey;
    private static String apiUrl;

    private static void loadConfig() {
        API_Config__mdt config = [SELECT API_Key__c, API_Endpoint__c FROM API_Config__mdt WHERE DeveloperName = 'NASA_Config' LIMIT 1];
        apiKey = config.API_Key__c;
        apiUrl = config.API_Endpoint__c;
    }
    private static String getApiKey() {
        if (String.isEmpty(apiKey)) {
            loadConfig();
        }
        return apiKey;
    }

    private static String getApiUrl() {
        if (String.isEmpty(apiUrl)) {
            loadConfig();
        }
        return apiUrl;
    }
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getRoverPhotos(String camera, String earthDate) {
        String key = getApiKey();
        String url = getApiUrl();
        
        String requestUrl;
        if (camera == 'All') {
            requestUrl = url + '?earth_date=' + earthDate + '&api_key=' + key;
        } else {
            requestUrl = url + '?earth_date=' + earthDate + '&camera=' + camera + '&api_key=' + key;
            
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
