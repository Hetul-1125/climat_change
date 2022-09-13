import 'package:clima_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
  LocationScreen({this.locationweather});
  final locationweather;
}

class _LocationScreenState extends State<LocationScreen> {
  int? Tempratuer;
  int? id;
  String? city;
  String? weathericon;
  String? weathermessage;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationweather);
    print(city);
  }

  updateUI(dynamic weather) {
    setState(() {
      if (weather == null) {
        Tempratuer = 0;
        weathericon = 'Error';
        weathermessage = 'Unable to get data';
        city=' ';

        return;
      }
      double temp = weather['main']['temp'] - 273.15;
      Tempratuer = temp.toInt();
      weathermessage = weatherModel.getMessage(Tempratuer!);
      id = weather['weather'][0]['id'];
      weathericon = weatherModel.getWeatherIcon(id!);
      city =weather['name'];
      print(city);
      print(id);
      print(Tempratuer);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getLocationdata();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                      if (typedname != null) {
                        var weatherData =
                            await weatherModel.getcityweather(typedname);
                        updateUI(weatherData);

                      }
                      ;
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      Tempratuer.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text('$weathermessage! in $city',
                    textAlign: TextAlign.right, style: kMessageTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
