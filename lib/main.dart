import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
void main () {
  runApp(myApp());
}
class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}
/*
{
"coord": {
"lon": 10.99,
"lat": 44.34
},
"weather": [
{
"id": 501,
"main": "Rain",
"description": "moderate rain",
"icon": "10d"
}
],
"base": "stations",
"main": {
"temp": 298.48,
"feels_like": 298.74,
"temp_min": 297.56,
"temp_max": 300.05,
"pressure": 1015,
"humidity": 64,
"sea_level": 1015,
"grnd_level": 933
},
"visibility": 10000,
"wind": {
"speed": 0.62,
"deg": 349,
"gust": 1.18
},
"rain": {
"1h": 3.16
},
"clouds": {
"all": 100
},
"dt": 1661870592,
"sys": {
"type": 2,
"id": 2075663,
"country": "IT",
"sunrise": 1661834187,
"sunset": 1661882248
},
"timezone": 7200,
"id": 3163858,
"name": "Zocca",
"cod": 200
}
*/

class _myAppState extends State<myApp> {
  var currentCity;
  var currentTemparature;
  var currentDescription;
  var statusCode;
  TextEditingController cityNameController = new TextEditingController();
  void getWeather () async {
    print("clicked");
    String cityName = cityNameController.text;
    final queryParameter = {
      "q": cityName,
      "appid": "1fe044b82345f27588bb3b1072b35d9e"
    };
    Uri uri = new Uri.https("api.openweathermap.org","data/2.5/weather",queryParameter);
    final jsonData = await get(uri);
    final json = jsonDecode(jsonData.body);

    setState(() {
      statusCode = json["cod"];
      currentCity = json["name"];
      currentTemparature = json["main"]["temp"];
      currentDescription = json["weather"][0]["description"];

    }
    );
    //print(statusCode);
    /*if (statusCode != 200) {
      print("vadar app banaisi");
      currentCity = "Wrong Input";
      currentTemparature = "Loading";
      currentDescription = "Loading";
    }*/
    /*try {
      if (statusCode == 200) {}
    }
    catch (ex) {
      currentCity = "Wrong Input";
      currentTemparature = "Loading";
      currentDescription = "Loading";
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text ("Weather App")),
        ),
        body: Center (
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Cunnerntly in " + (currentCity == null? "Loading" : currentCity.toString() ),
              style: TextStyle (
                fontSize: 30.0
              ),
              ),
              Text((currentTemparature == null? "Loading" : (currentTemparature-273).toStringAsFixed(2) + "\u00B0"),
                style: TextStyle (
                    fontSize: 50.0
                ),
              ),
              Text((currentDescription == null ? "Loading" : currentDescription.toString()),
              style: TextStyle (
                fontSize:30.0
              ),
              ),
              SizedBox(
                width: 190.0,
                child: TextField(
                  controller: cityNameController,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                  onPressed: getWeather,
                  child: Text("Search")
              )
            ],
          ),
        ),
      ),
    );
  }
}
