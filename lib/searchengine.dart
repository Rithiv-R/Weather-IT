import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class Searcher extends StatefulWidget {
  String city;
  Searcher({this.city});
  @override
  _SearcherState createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  var json;
  @override
  void initState() {
    super.initState();

    fetchdata(widget.city);
  }

  Future fetchdata(String city) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&q=$city&appid=76ead4bbf3eda576a999e80ba6a989da'));
    setState(() {
      json = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('WEATHER-IT',
            style: GoogleFonts.rakkas(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
            )),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orangeAccent),
      ),
      body: json == null
          ? CircularProgressIndicator()
          : Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 550,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 100,
                            spreadRadius: 10,
                            color: Colors.orangeAccent,
                            offset: Offset(0, 0)),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(200, 70),
                          bottomRight: Radius.elliptical(200, 70)),
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.center,
                          colors: [Colors.orangeAccent, Colors.orange[300]]),
                    ),
                  ),
                  Container(
                    height: 550,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            json['name'].toString().toUpperCase(),
                            style: GoogleFonts.rakkas(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: 200,
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1592210454359-9043f067919b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2VhdGhlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  (json['main']['temp']).toString() + '°C',
                                  style: GoogleFonts.aladin(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                left: 20,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                    json['weather'][0]['description']
                                        .toString()
                                        .toUpperCase(),
                                    style: GoogleFonts.rakkas(
                                        color: Colors.white, fontSize: 30)))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Divider(
                            height: 2,
                            thickness: 2,
                            color: Colors.white,
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                makecard(
                                    WeatherIcons.windy,
                                    json['wind']['speed'].toString(),
                                    'WIND SPEED'),
                                Padding(padding: EdgeInsets.only(left: 5)),
                                makecard(
                                    WeatherIcons.humidity,
                                    json['main']['humidity'].toString(),
                                    'HUMIDITY'),
                                makecard(
                                    Icons.arrow_upward,
                                    json['main']['temp_max'].toString(),
                                    'MAX TEMP'),
                                makecard(
                                    Icons.arrow_downward,
                                    json['main']['temp_min'].toString(),
                                    'MIN TEMP'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget makecard(IconData i1, String i2, String i3) {
    return Card(
      color: Colors.orangeAccent,
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              i1,
              size: 20,
            ),
            Text(i2,
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(i3, style: GoogleFonts.rakkas(fontWeight: FontWeight.w100)),
          ],
        ),
      ),
    );
  }
}
