import ballerina/io;
import pubudu/weather;
import ballerina/config;

public function main(string... args) {
    weather:RefinedClient wClient = new(config:getAsString("api.key"));
    var resp = wClient->getWeather("Sri Lanka", unit = weather:TEMP_UNIT_IMPERIAL);
    io:println(resp);
}