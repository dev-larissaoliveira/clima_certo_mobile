class WeatherResponse {
  final Results results;

  WeatherResponse({required this.results});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      results: Results.fromJson(json['results'] as Map<String, dynamic>),
    );
  }
}

class Results {
  final int temp;
  final String date;
  final String conditionCode;
  final String description;
  final String currently;
  final String city;
  final String imgId;
  final int humidity;
  final int cloudiness;
  final int rain;
  final String windSpeedy;
  final String windCardinal;
  final String cityName;
  final List<Forecast> forecast;

  Results({
    required this.temp,
    required this.date,
    required this.conditionCode,
    required this.description,
    required this.currently,
    required this.city,
    required this.imgId,
    required this.humidity,
    required this.cloudiness,
    required this.rain,
    required this.windSpeedy,
    required this.windCardinal,
    required this.cityName,
    required this.forecast,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      temp: json['temp'] as int,
      date: json['date'] as String? ?? '',
      conditionCode: json['conditionCode'] as String? ?? '',
      description: json['description'] as String? ?? '',
      currently: json['currently'] as String? ?? '',
      city: json['city'] as String? ?? '',
      imgId: json['imgId'] as String? ?? '',
      humidity: json['humidity'] as int,
      cloudiness: json['cloudiness'] as int,
      rain: json['rain'] as int,
      windSpeedy: json['windSpeedy'] as String? ?? '',
      windCardinal: json['windCardinal'] as String? ?? '',
      cityName: json['cityName'] as String? ?? '',
      forecast: (json['forecast'] as List<dynamic>)
          .map((e) => Forecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Forecast {
  final String date;
  final String weekday;
  final int max;
  final int min;
  final int cloudiness;
  //final double rain;
  final int rainProbability;
  final String windSpeedy;
  final String description;
  final String condition;

  Forecast({
    required this.date,
    required this.weekday,
    required this.max,
    required this.min,
    required this.cloudiness,
    //required this.rain,
    required this.rainProbability,
    required this.windSpeedy,
    required this.description,
    required this.condition,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['date'] as String,
      weekday: json['weekday'] as String,
      max: json['max'] as int,
      min: json['min'] as int,
      cloudiness: json['cloudiness'] as int,
      //rain: json['rain'],
      rainProbability: json['rainProbability'] as int,
      windSpeedy: json['windSpeedy'] as String? ?? '',
      description: json['description'] as String,
      condition: json['condition'] as String,
    );
  }
}
