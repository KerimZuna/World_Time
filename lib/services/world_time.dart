import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String? location; //naziv lokacije za UI
  String? time; // vrijeme na toj lokaciji
  String? flag; // url za zastavicu
  String? url; // url za lokaciju API endpoint-a
  bool? isDayTime; //ako je true pokazuje sliku dana, ako ne onda noci

  WorldTime({this.location, this.flag, this.url});

  Future<void> getData() async{
    try{
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];

      DateTime now = DateTime.parse(datetime.substring(0,26));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now); // postavljamo vrijeme
    }catch (e){
      print('Caught error: $e');
      time = 'Failed to get the time';
    }
  }
}
