import ballerina/http;
import ballerina/io;

public function main() {
    http:Client clientEP = new("http://dummy.restapiexample.com/api/v1/");
    http:Response|error response = clientEP->get("/employee/4466");
    
    if (response is http:Response) {
        json|error payload = response.getJsonPayload();
        io:println(payload);
    }
}