@IsTest
private class MarsRoverServiceTest {

    // Mock class to simulate HTTP callout
    private class MarsRoverCalloutMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            // Create a fake HTTP response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setStatusCode(200);
            // Sample JSON response similar to what the Mars Rover API might return
            response.setBody('{"photos":[{"id": 1, "img_src": "http://example.com/photo.jpg"}]}');
            return response;
        }
    }

    @IsTest
    static void testGetRoverPhotos() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new MarsRoverCalloutMock());

        // Execute the test method
        Test.startTest();
        List<MarsRoverService.MarsPhoto> photos = MarsRoverService.getRoverPhotos('FHAZ', '2021-09-01');
        Test.stopTest();

        // Verify the results
        System.assertEquals(1, photos.size(), 'Expected to find one photo');
        MarsRoverService.MarsPhoto photo = photos[0];
        System.assertEquals('http://example.com/photo.jpg', photo.imageUrl, 'The photo URL should match the mock response');
    }
}
