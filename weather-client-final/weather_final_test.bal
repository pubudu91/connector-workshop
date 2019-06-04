import ballerina/config;
import ballerina/io;
import pubudu/weather;

public function main(string... args) {
    weather:RefinedClient wClient = new(config:getAsString("api.key"));
    var resp = wClient->getWeather(untaint args[0], unit = untaint <weather:TemperatureUnit>args[1]);
    io:println(resp);
}