package org.bookbook.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/api")
@Log4j
public class PythonBootController {

    // Replace this URL with your actual Flask server URL
    private static final String FLASK_URL = "http://localhost:5000/api/endpoint";

    @GetMapping("/getData")
    public ResponseEntity<String> getData() {
        // Create a WebClient
        WebClient webClient = WebClient.create();

        // Data to be sent as a query parameter
        String dataToSend = "Hello from Spring Boot";

        String dataToSend2 = "test data send to Flask";

        // Append the data to the URL as a query parameter
        String urlWithParams = FLASK_URL + "?data=" + dataToSend + "&data2=" + dataToSend2;

        // Send a GET request to the Flask server
        String flaskResponse = webClient.get()
                .uri(urlWithParams)
                .retrieve()
                .bodyToMono(String.class)
                .block(); // block to wait for the response

        // You can add additional logic here based on the Flask response
        // log.info("Received response from Flask: " + flaskResponse);

        // Return the response from Spring
        return ResponseEntity.ok("Hello from Spring. Flask says: " + flaskResponse);
    }

    @PostMapping("/endpoint")
    public ResponseEntity<String> receiveData(@RequestBody String requestData) {
        System.out.println("Received data: " + requestData);

        return new ResponseEntity<>("Data received successfully", HttpStatus.OK);
    }

}
