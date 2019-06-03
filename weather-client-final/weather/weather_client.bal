import ballerina/http;
import ballerina/io;

public type RefinedClient client object {

    private http:Client weatherEP;
    private string apiKey;

    public function __init(string apiKey) {
        self.weatherEP = new("http://api.openweathermap.org/data/2.5/");
        self.apiKey = apiKey;
    }

    public remote function getWeather(string city, TemperatureUnit unit = "kelvin") returns WeatherInfo|error {
        string url = self.buildURL("/weather", city, unit);

        http:Response|error resp = self.weatherEP->get(url);

        if (resp is http:Response) {
            json|error payload = resp.getJsonPayload();

            if (payload is json) {
                WeatherInfo|error convPayload = WeatherInfo.convert(payload);

                if (convPayload is WeatherInfo) {
                    return convPayload;
                } else {
                    WeatherClientError err = error("Failed to map the payload to `WeatherInfo`", 
                                                        {"payload": payload, "cause": convPayload});
                    return err;
                }
            } else {
                return payload;
            }
        } else {
            return resp;
        }
    }

    private function buildURL(string res, string city, TemperatureUnit unit) returns string {
        string url = res + "?q=" + city;

        if (unit == TEMP_UNIT_KELVIN) {
            // do nothing
        } else {
            url += "&unit=" + <string>unit;
        }

        return url + "&appid=" + self.apiKey;
    }
};
