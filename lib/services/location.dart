import 'package:geolocator/geolocator.dart';
class Location {
  double? latitude;
  double? longitude;

  Future<void>getCurrentlocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude=position.latitude;
      longitude=position.longitude;

    }
    catch (e) {
      print(e);
    }
  }
}
// var Tempratuer=jsonDecode(data)['main']['temp'];
// var id=jsonDecode(data)['weather'][0]['id'];
// var country=jsonDecode(data)['sys']['country'];