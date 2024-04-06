@IsTest
private class MarsRoverServiceTest {
    // Mock class to simulate the HTTP callout response
    private class MockHttpCallout implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            // Create a fake HTTP response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setStatusCode(200);
            // Provide a sample JSON response that mimics the structure of the NASA API response
            response.setBody('{' +
                '"photos": [' +
                '  {' +
                '    "id": 102685,' +
                '    "img_src": "http://example.com/mars.jpg",' +
                '    "earth_date": "2015-06-03",' +
                '    "camera": {"name": "FHAZ"}' +
                '  }' +
                ']' +
                '}');
            return response;
        }
    }

    @IsTest
    static void testGetRoverPhotos() {
        // Set the mock callout
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout());

        // Call the method to test
        Test.startTest();
        List<Map<String, Object>> photos = MarsRoverService.getRoverPhotos('FHAZ', '2015-6-3');
        Test.stopTest();

        // Verify the results
        System.assert(photos != null, 'The photos list should not be null');
        System.assertEquals(1, photos.size(), 'Expected to find one photo');
        Map<String, Object> photo = photos.get(0);
        System.assertEquals(102685, photo.get('id'), 'The photo ID should match the mock response');
        System.assertEquals('http://example.com/mars.jpg', photo.get('img_src'), 'The photo URL should match the mock response');
    }
}
