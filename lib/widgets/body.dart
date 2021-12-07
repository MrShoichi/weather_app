import 'dart:convert';
import 'dart:developer';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:weather_app/theme/CustomTheme.dart';
import 'package:weather_app/widgets/week_page.dart';
import 'package:http/http.dart' as http;
import 'head.dart';
import 'loading.dart';

class Body extends StatefulWidget {
  const Body(
      {Key key,
      @required this.settings,
      @required this.state,
      @required this.days,
      @required this.current,
      @required this.hourly,
      @required this.favourites,
      @required this.favouriteCity,
        @required this.theme})
      : super(key: key);
  final Map settings;
  final ThemeData theme;
  final Map<String, dynamic> current;
  final List<dynamic> days;
  final List<dynamic> hourly;
  final List<String> favourites;
  final String favouriteCity;
  final void Function(VoidCallback fn) state;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool openState = false;



  Future<Map<String, dynamic>> func(int lat, int lon) async {
    var url = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&&appid=d542f2dc93eab9b9bbfb73430bdc8c29'));
    var r = jsonDecode(url.body);
    widget.state(() {});
    return r;
  }

  int getTemp(num Kelvin) {
    if (!widget.settings["temp"]) {
      return (Kelvin - 273.15).round();
    } else {
      return ((Kelvin - 273.15) * 9 / 5 + 32).round();
    }
  }


  String getWind(num mc) {
    if (!widget.settings["wind"]) {
      return mc.toStringAsFixed(1);
    } else {
      return (mc / 1000).toStringAsFixed(3);
    }
  }

  String getBar(num bar) {
    if (widget.settings["bar"]) {
      return bar.toString();
    } else {
      return (bar / 1.33322).toStringAsFixed(2);
    }
  }
  String getImage(String time) {
    if(!(Theme.of(context).brightness == Brightness.dark)) {
      switch(time) {
      case "Clouds": return "images/cloudy.png";
      case "Snow": return "images/snow.png";
      case "Clear": return "images/clear.png";
      case "Thunderstorm": return "images/light.png";
      case "Mist":
      case "Smoke":
      case "Haze":
      case "Fog":
      case "Ash":
      case "Squall": return "images/smog.png";
      case "Rain":
      case "Drizzle": return "images/rain.png";
    }
    } else {
      switch(time) {
        case "Clouds": return "images/darkCloudy.png";
        case "Snow": return "images/darkSnow.png";
        case "Clear": return "images/darkClear.png";
        case "Thunderstorm": return "images/darkLight.png";
        case "Mist":
        case "Smoke":
        case "Haze":
        case "Fog":
        case "Ash":
        case "Squall": return "images/darkSmog.png";
        case "Rain": return "images/darkRains.png";
        case "Drizzle": return "images/darkRain.png";
        }
    }

  }
  bool flag = true;

  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {

    String temp = widget.settings['temp'] ? "°F" : "°C";
    String wind = widget.settings['wind'] ? "км/c" : "м/c";
    String bar = widget.settings['bar'] ? "гПа" : "мм.рт.ст";
    int morning = (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,6,0,0).millisecondsSinceEpoch/1000).round();
    int day = (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0,0).millisecondsSinceEpoch/1000).round();
    int eve = (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,18,0,0).millisecondsSinceEpoch/1000).round();
    int night = (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,24,0,0).millisecondsSinceEpoch/1000).round();
    Set<String> month = {
      "января",
      "февраля",
      "марта",
      "апреля",
      "майя",
      "июня",
      "июля",
      "августа",
      "сентября",
      "октября",
      "ноября",
      "декабря"
    };
    DateTime currentDate;

    currentDate = DateTime.fromMillisecondsSinceEpoch(widget.days[0]["dt"] * 1000);
    return Container(

      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Head(
                    openState: openState,
                    settings: widget.settings,
                    current: widget.current,
                    favourites: widget.favourites,
                    favouriteCity: widget.favouriteCity,
                    theme: widget.theme
                  )
                ],
              ),
            ),
          ),
        ),
        ExpandableBottomSheet(

            persistentContentHeight: 220,
            onIsContractedCallback: () {
              setState(() {
                openState = false;
              });
            },
            onIsExtendedCallback: () {
              setState(() {
                openState = true;
              });
            },
            enableToggle: true,
            background: Container(),
            persistentHeader: Container(
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                ),
                color: Theme.of(context).bottomSheetTheme.backgroundColor,
              ),
              constraints: BoxConstraints.expand(height: 40),
              child: Center(
                child: Container(
                  height: 3.0,
                  width: 60.0,
                  color: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
                ),
              ),
            ),
            expandableContent: Container(
              constraints: BoxConstraints(maxHeight: 600),
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              child: Center(
                child: Column(
                  children: [
                    Visibility(
                      visible: openState,
                      child: Text(
                        currentDate.day.toString() +
                            " " +
                            month.elementAt(
                                int.parse(currentDate.month.toString()) - 1),
                        style: TextStyle(
                          //color: Colors.black,
                          fontFamily: "ManropeStyle",
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Padding(
                      padding: openState
                          ? EdgeInsets.fromLTRB(0, 32, 0, 0)
                          : EdgeInsets.all(0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10)),
                                    depth: 2,
                                    intensity: 0.5,
                                    lightSource: LightSource.topLeft,
                                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                  ),
                                  child: SizedBox(
                                    height: 122,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            DateTime.fromMillisecondsSinceEpoch(widget.hourly[0]["dt"] * 1000).hour.toString() + ":00",
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Image(
                                            height: 50,
                                            image:
                                                AssetImage(getImage(widget.hourly[0]["weather"][0]["main"]))),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            getTemp(widget.hourly[0]["temp"].toDouble())
                                                    .toString() +
                                                temp,
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10)),
                                    depth: 2,
                                    intensity: 0.5,
                                    lightSource: LightSource.topLeft,
                                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                  ),
                                  child: SizedBox(
                                    height: 122,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            DateTime.fromMillisecondsSinceEpoch(widget.hourly[6]["dt"] * 1000).hour.toString() + ":00",
                                            style: TextStyle(
                                             // color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Image(
                                            height: 50,
                                            image:
                                                AssetImage(getImage(widget.hourly[6]["weather"][0]["main"]))),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            getTemp(widget.hourly[6]["temp"].toDouble())
                                                    .toString() +
                                                temp,
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10)),
                                    depth: 2,
                                    intensity: 0.5,
                                    lightSource: LightSource.topLeft,
                                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                  ),
                                  child: SizedBox(
                                    height: 122,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            DateTime.fromMillisecondsSinceEpoch(widget.hourly[12]["dt"] * 1000).hour.toString() + ":00",
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Image(
                                            height: 50,
                                            image:
                                                AssetImage(getImage(widget.hourly[12]["weather"][0]["main"]))),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            getTemp(widget.hourly[12]["temp"].toDouble())
                                                    .toString() +
                                                temp,
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 20, 0),
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10)),
                                    depth: 2,
                                    intensity: 0.5,
                                    lightSource: LightSource.topLeft,
                                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                  ),
                                  child: SizedBox(
                                    height: 122,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            DateTime.fromMillisecondsSinceEpoch(widget.hourly[18]["dt"] * 1000).hour.toString() + ":00",
                                            style: TextStyle(
                                             // color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Image(
                                            height: 50,
                                            image:
                                                AssetImage(getImage(widget.hourly[18]["weather"][0]["main"]))),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(9, 7, 9, 0),
                                          child: Text(
                                            getTemp(widget.hourly[18]["temp"].toDouble())
                                                    .toString() +
                                                temp,
                                            style: TextStyle(
                                            //  color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                          ]),
                    ),
                    Visibility(
                        visible: !openState,
                        child: Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => WeekPage(days: widget.days, settings: widget.settings,)));
                              },
                              /*style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xffeaf0ff)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                             // color: Color(0xff038cfe)
                                          )))),*/
                              child: Text(
                                "Прогноз на неделю",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontFamily: "ManropeStyle",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          );
                        })),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10)),
                                    depth: 10,
                                    intensity: 0.5,
                                    lightSource: LightSource.topLeft,
                                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                  ),
                                  child: SizedBox(
                                    height: 75,
                                    width: 170,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.thermostat_outlined,
                                          //color: Color(0xFF5A5A5A),
                                        ),
                                        Text(
                                          getTemp(widget.current["temp"]).toString(),
                                          style: TextStyle(
                                            //color: Colors.black,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          temp.toLowerCase(),
                                          style: TextStyle(
                                            //color: Color(0xff5A5A5A),
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10)),
                                    depth: 10,
                                    intensity: 0.5,
                                    lightSource: LightSource.topLeft,
                                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                  ),
                                  child: SizedBox(
                                    height: 75,
                                    width: 170,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.water,
                                          //color: Color(0xFF5A5A5A),
                                        ),
                                        Text(
                                          widget.current["humidity"].toString(),
                                          style: TextStyle(
                                            //color: Colors.black,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          "%",
                                          style: TextStyle(
                                            //color: Color(0xff5A5A5A),
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                          ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(10)),
                                      depth: 10,
                                      intensity: 0.5,
                                      lightSource: LightSource.topLeft,
                                      color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                    ),
                                    child: SizedBox(
                                      height: 75,
                                      width: 170,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.air_outlined,
                                            //color: Color(0xFF5A5A5A),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 0, 0, 0),
                                            child: Text(
                                              getWind(widget.current["wind_speed"]),
                                              style: TextStyle(
                                               // color: Colors.black,
                                                fontFamily: "ManropeStyle",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            wind,
                                            style: TextStyle(
                                              //color: Color(0xff5A5A5A),
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              )),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(10)),
                                      depth: 10,
                                      intensity: 0.5,
                                      lightSource: LightSource.topLeft,
                                      color: Theme.of(context).bottomSheetTheme.backgroundColor,
                                    ),
                                    child: SizedBox(
                                      height: 75,
                                      width: 170,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.compress_outlined,
                                            //color: Color(0xFF5A5A5A),
                                          ),
                                          Text(
                                            getBar(widget.current["pressure"]),
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            bar,
                                            style: TextStyle(
                                              //color: Color(0xff5A5A5A),
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              )),
                            ]))
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}
