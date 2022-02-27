class WeatherInfo {
  WeatherInfo(
      {required this.localTime,
      required this.tempC,
      required this.iconUrl,
      required this.name,
      required this.region,
      required this.country});

  final String localTime;
  final int tempC;
  final String iconUrl;
  final String name;
  final String region;
  final String country;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        name: json['location']['name'],
        region: json['location']['region'],
        country: json['location']['country'],
        localTime: json['location']['localtime'],
        tempC: (json['current']['temp_c'] as double).round(),
        iconUrl: 'http:' + json['current']['condition']['icon']);
  }

  factory WeatherInfo.getDummy() {
    return WeatherInfo(
        localTime: "2022-02-13 17:25",
        tempC: 9,
        iconUrl: "http:${"//cdn.weatherapi.com/weather/64x64/night/296.png"}",
        name: "London",
        region: "City of London, Greater London",
        country: "United Kingdom");
  }
}