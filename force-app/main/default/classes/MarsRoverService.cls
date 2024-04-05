public with sharing class MarsRoverService {
    private static final String API_URL = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos';
    private static final String API_KEY = 'WKjR8Q56dyBeJsYXNbAVqkD9zdw3kXLcUUAat4Cn';

    @AuraEnabled(cacheable=true)
    public static List<MarsPhoto> getRoverPhotos(String camera, String earthDate) {
        if (earthDate == null || camera == null) {
            earthDate = '2015-6-3';
            camera = 'FHAZ';
        }
        String requestUrl = API_URL + '?earth_date=' + earthDate + '&camera=' + camera + '&api_key=' + API_KEY;
        // String requestUrl = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY';
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
            List<Object> photoList = new List<Object>();
            for (Object photoObj : (List<Object>)results.get('photos')) {
                Map<String, Object> photoMap = (Map<String, Object>)photoObj;
    
                // Construct a new Map for each photo with the necessary information
                Map<String, Object> photoInfo = new Map<String, Object>();
                photoInfo.put('id', (Integer)photoMap.get('id'));
                photoInfo.put('imageUrl', (String)photoMap.get('img_src'));
                // Add other fields as necessary
                
                photoList.add(photoInfo);
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

//example api response
// {
//   "photos": [
//     {
//       "id": 102685,
//       "sol": 1004,
//       "camera": {
//         "id": 20,
//         "name": "FHAZ",
//         "rover_id": 5,
//         "full_name": "Front Hazard Avoidance Camera"
//       },
//       "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG",
//       "earth_date": "2015-06-03",
//       "rover": {
//         "id": 5,
//         "name": "Curiosity",
//         "landing_date": "2012-08-06",
//         "launch_date": "2011-11-26",
//         "status": "active",
//         "max_sol": 4102,
//         "max_date": "2024-02-19",
//         "total_photos": 695670,
//         "cameras": [
//           {
//             "name": "FHAZ",
//             "full_name": "Front Hazard Avoidance Camera"
//           },
//           {
//             "name": "NAVCAM",
//             "full_name": "Navigation Camera"
//           },
//           {
//             "name": "MAST",
//             "full_name": "Mast Camera"
//           },
//           {
//             "name": "CHEMCAM",
//             "full_name": "Chemistry and Camera Complex"
//           },
//           {
//             "name": "MAHLI",
//             "full_name": "Mars Hand Lens Imager"
//           },
//           {
//             "name": "MARDI",
//             "full_name": "Mars Descent Imager"
//           },
//           {
//             "name": "RHAZ",
//             "full_name": "Rear Hazard Avoidance Camera"
//           }
//         ]
//       }
//     },
//     {
//       "id": 102686,
//       "sol": 1004,
//       "camera": {
//         "id": 20,
//         "name": "FHAZ",
//         "rover_id": 5,
//         "full_name": "Front Hazard Avoidance Camera"
//       },
//       "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FRB_486615455EDR_F0481570FHAZ00323M_.JPG",
//       "earth_date": "2015-06-03",
//       "rover": {
//         "id": 5,
//         "name": "Curiosity",
//         "landing_date": "2012-08-06",
//         "launch_date": "2011-11-26",
//         "status": "active",
//         "max_sol": 4102,
//         "max_date": "2024-02-19",
//         "total_photos": 695670,
//         "cameras": [
//           {
//             "name": "FHAZ",
//             "full_name": "Front Hazard Avoidance Camera"
//           },
//           {
//             "name": "NAVCAM",
//             "full_name": "Navigation Camera"
//           },
//           {
//             "name": "MAST",
//             "full_name": "Mast Camera"
//           },
//           {
//             "name": "CHEMCAM",
//             "full_name": "Chemistry and Camera Complex"
//           },
//           {
//             "name": "MAHLI",
//             "full_name": "Mars Hand Lens Imager"
//           },
//           {
//             "name": "MARDI",
//             "full_name": "Mars Descent Imager"
//           },
//           {
//             "name": "RHAZ",
//             "full_name": "Rear Hazard Avoidance Camera"
//           }
//         ]
//       }
//     },
//     {
//       "id": 102842,
//       "sol": 1004,
//       "camera": {
//         "id": 21,
//         "name": "RHAZ",
//         "rover_id": 5,
//         "full_name": "Rear Hazard Avoidance Camera"
//       },
//       "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/rcam/RLB_486615482EDR_F0481570RHAZ00323M_.JPG",
//       "earth_date": "2015-06-03",
//       "rover": {
//         "id": 5,
//         "name": "Curiosity",
//         "landing_date": "2012-08-06",
//         "launch_date": "2011-11-26",
//         "status": "active",
//         "max_sol": 4102,
//         "max_date": "2024-02-19",
//         "total_photos": 695670,
//         "cameras": [
//           {
//             "name": "FHAZ",
//             "full_name": "Front Hazard Avoidance Camera"
//           },
//           {
//             "name": "NAVCAM",
//             "full_name": "Navigation Camera"
//           },
//           {
//             "name": "MAST",
//             "full_name": "Mast Camera"
//           },
//           {
//             "name": "CHEMCAM",
//             "full_name": "Chemistry and Camera Complex"
//           },
//           {
//             "name": "MAHLI",
//             "full_name": "Mars Hand Lens Imager"
//           },
//           {
//             "name": "MARDI",
//             "full_name": "Mars Descent Imager"
//           },
//           {
//             "name": "RHAZ",
//             "full_name": "Rear Hazard Avoidance Camera"
//           }
//         ]
//       }
//     },
//     {
//       "id": 102843,
//       "sol": 1004,
//       "camera": {
//         "id": 21,
//         "name": "RHAZ",
//         "rover_id": 5,
//         "full_name": "Rear Hazard Avoidance Camera"
//       },
//       "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/rcam/RRB_486615482EDR_F0481570RHAZ00323M_.JPG",
//       "earth_date": "2015-06-03",
//       "rover": {
//         "id": 5,
//         "name": "Curiosity",
//         "landing_date": "2012-08-06",
//         "launch_date": "2011-11-26",
//         "status": "active",
//         "max_sol": 4102,
//         "max_date": "2024-02-19",
//         "total_photos": 695670,
//         "cameras": [
//           {
//             "name": "FHAZ",
//             "full_name": "Front Hazard Avoidance Camera"
//           },
//           {
//             "name": "NAVCAM",
//             "full_name": "Navigation Camera"
//           },
//           {
//             "name": "MAST",
//             "full_name": "Mast Camera"
//           },
//           {
//             "name": "CHEMCAM",
//             "full_name": "Chemistry and Camera Complex"
//           },
//           {
//             "name": "MAHLI",
//             "full_name": "Mars Hand Lens Imager"
//           },
//           {
//             "name": "MARDI",
//             "full_name": "Mars Descent Imager"
//           },
//           {
//             "name": "RHAZ",
//             "full_name": "Rear Hazard Avoidance Camera"
//           }
//         ]
//       }
//     }
//   ]
// }