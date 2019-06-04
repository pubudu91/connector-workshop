import ballerina/io;
import pubudu/weather;
import ballerina/config;

public function main(string... args) {
    weather:RefinedClient wClient = new(config:getAsString("api.key"));
    var resp = wClient->getWeather(untaint args[0], unit = weather:TEMP_UNIT_METRIC);
    io:println(resp);
}