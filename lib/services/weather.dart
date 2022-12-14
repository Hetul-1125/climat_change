import 'package:clima_flutter/services/networking.dart';
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:clima_flutter/services/location.dart';
class WeatherModel {
  getcityweather(String cityname)async{
    Networking networking=Networking("https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=c81483d21ef1ecabec622faf828bb2a2");
    var weather=await networking.getdata();
    return weather;

  }
  Future getLocationdata()async
  {
    Location location = Location();
    await location.getCurrentlocation();
    Networking networking = Networking(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=c81483d21ef1ecabec622faf828bb2a2");
    var weather = await networking.getdata();
      return weather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
