import ballerina/io;
import pubudu/weather;

public function main(string... args) {
    weather:RefinedClient wClient = new("786039d58c22d45b4dfbbd736a863554");
    var resp = wClient->getWeather("Colombo", unit = weather:TEMP_UNIT_IMPERIAL);
    io:println(resp);
}