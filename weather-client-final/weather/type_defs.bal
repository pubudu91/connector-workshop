public const TEMP_UNIT_KELVIN = "kelvin";
public const TEMP_UNIT_METRIC = "metric";
public const TEMP_UNIT_IMPERIAL = "imperial";

public type TemperatureUnit TEMP_UNIT_KELVIN|TEMP_UNIT_METRIC|TEMP_UNIT_IMPERIAL;

public type ErrorReason "Failed to map the payload to `WeatherInfo`";

public type WeatherClientError error<ErrorReason, map<anydata|error>>;

public type WeatherInfo record {|
    int id;
    string name;
    Coordinates coord;
    Weather[] weather;
    string base;
    Main main;
    Wind wind?;
    Clouds clouds?;
    Rain rain?;
    Snow snow?;
    int dt;
    System sys;
    int cod;
    int visibility;
    int timezone?;
|};

public type Coordinates record {|
    float lon;
    float lat;
|};

public type Weather record {|
    int id;
    string main;
    string description;
    string icon;
|};

public type Main record {|
    float temp;
    int pressure;
    int humidity;
    float temp_min;
    float temp_max;
    float sea_level?;
    float grnd_level?;
|};

public type Wind record {|
    float speed;
    int deg?;
|};

public type Clouds record {|
    int ^"all";
|};

public type Rain record {|
    int ^"1h";
    int ^"3h";
|};

public type Snow record {|
    int ^"1h";
    int ^"3h";
|};

public type System record {|
    int ^"type";
    int id;
    float message;
    string country;
    int sunrise;
    int sunset;
|};
