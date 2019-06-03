import pubudu/weather;
import ballerina/io;

public function main(string... args) {
    weather:Client wClient = new("786039d58c22d45b4dfbbd736a863554");
    json|error resp = wClient->getWeather("Colombo", unit = "metric");
    io:println(resp);
}