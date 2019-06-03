import ballerina/http;
import ballerina/io;

public type RefinedClient client object {

    private http:Client weatherEP;
    private string apiKey;

    public function __init(string apiKey) {
        self.weatherEP = new("http://api.openweathermap.org/data/2.5/");
        self.apiKey = apiKey;
    }

    public remote function getWeather(string location, TemperatureUnit unit = "kelvin") returns WeatherInfo|error {
        string url = self.buildURL("/weather", location, unit);

        http:Response|error resp = self.weatherEP->get(url);

        if (resp is http:Response) {
            json|error payload = resp.getJsonPayload();

            if (payload is json) {
                return WeatherInfo.convert(payload);
            } else {
                return payload;
            }
        } else {
            return resp;
        }
    }

    private function buildURL(string res, string location, TemperatureUnit unit) returns string {
        string url = res + "?q=" + location;

        if (unit == TEMP_UNIT_KELVIN) {
            // do nothing
        } else {
            url += "&unit=" + <string>unit;
        }

        return url + "&appid=" + self.apiKey;
    }
};
