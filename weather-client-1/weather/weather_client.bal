import ballerina/http;
import ballerina/log;

public type Client client object {

    private http:Client weatherEP;
    private string apiKey;

    public function __init(string apiKey) {
        self.weatherEP = new("http://api.openweathermap.org/data/2.5/");
        self.apiKey = apiKey;
    }

    public remote function getWeather(string location, string unit = "kelvin") returns json|error {
        string|error url = self.buildURL("/weather", location, unit);

        if (url is string) {
            http:Response|error resp = self.weatherEP->get(url);

            if (resp is http:Response) {
                return resp.getJsonPayload();
            } else {
                return resp;
            }
        } else {
            return url;
        }
    }

    private function buildURL(string res, string loc, string unit) returns string|error {
        string url = res + "?q=" + loc;

        match unit {
            "kelvin" => {} // do nothing
            "metric" => url += "&unit=metric";
            "imperial" => url += "&unit=imperial";

            _ => {
                error e = error("Invalid unit: " + unit);
                return e;
            }
        }

        return url + "&appid=" + self.apiKey;
    }
};
