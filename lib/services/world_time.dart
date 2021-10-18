import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; // location name for the UI
  late String time = ""; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoints
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var myurl = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      var response = await http.get(myurl);
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      DateTime now = DateTime.parse(datetime.substring(0, 26));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      // print('caught error: $e');
      time = 'Could not get time data';
    }
  }

}
