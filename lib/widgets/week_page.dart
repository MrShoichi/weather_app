
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weather_app/widgets/weather_item.dart';

class WeekPage extends StatelessWidget {


  WeekPage({Key key, @required this.days, @required this.settings}) : super(key: key);
  final List<dynamic> days;
  final Map settings;
  int getTemp(double Kelvin) {
    if (!settings["temp"]) {
      return (Kelvin - 273.15).round();
    } else {
      return ((Kelvin - 273.15) * 9 / 5 + 32).round();
    }
  }
  String getWind(double mc) {
    if (!settings["wind"]) {
      return mc.toStringAsFixed(1);
    } else {
      return (mc / 1000).toStringAsFixed(3);
    }
  }

  String getBar(int bar) {
    if (settings["bar"]) {
      return bar.toString();
    } else {
      return (bar / 1.33322).toStringAsFixed(2);
    }
  }
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
  String getImage(String time) {
      switch(time) {
        case "Clouds": return "images/cloudyWeek.png";
        case "Snow": return "images/snowWeek.png";
        case "Clear": return "images/clearWeek.png";
        case "Thunderstorm": return "images/lightWeek.png";
        case "Mist":
        case "Smoke":
        case "Haze":
        case "Fog":
        case "Ash": return "images/smogWeek.png";
        case "Squall": return "images/smogWeek.png";
        case "Rain": return "images/rainsSunWeek.png";
        case "Drizzle": return "images/rainWeek.png";
      }

  }
  @override
  Widget build(BuildContext context) {
    List<WeatherItem> weathers = [
      WeatherItem(getImage(days[0]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[0]["dt"] * 1000).day.toString() + " " + month.elementAt(
          int.parse(DateTime.fromMillisecondsSinceEpoch(days[0]["dt"] * 1000).month.toString()) - 1), getTemp((days[0]["temp"]["min"] + days[0]["temp"]["max"]) / 2), getWind(days[0]["wind_speed"]), days[0]["humidity"].toString(), getBar(days[0]["pressure"])),
    WeatherItem(getImage(days[1]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[1]["dt"] * 1000).day.toString() + " " + month.elementAt(
    int.parse(DateTime.fromMillisecondsSinceEpoch(days[1]["dt"] * 1000).month.toString()) - 1), getTemp((days[1]["temp"]["min"] + days[1]["temp"]["max"]) / 2), getWind(days[1]["wind_speed"]), days[1]["humidity"].toString(), getBar(days[1]["pressure"])),
    WeatherItem(getImage(days[2]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[2]["dt"] * 1000).day.toString() + " " + month.elementAt(
    int.parse(DateTime.fromMillisecondsSinceEpoch(days[2]["dt"] * 1000).month.toString()) - 1), getTemp((days[2]["temp"]["min"] + days[2]["temp"]["max"]) / 2), getWind(days[2]["wind_speed"]), days[2]["humidity"].toString(), getBar(days[2]["pressure"])),
    WeatherItem(getImage(days[3]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[3]["dt"] * 1000).day.toString() + " " + month.elementAt(
    int.parse(DateTime.fromMillisecondsSinceEpoch(days[3]["dt"] * 1000).month.toString()) - 1), getTemp((days[3]["temp"]["min"] + days[3]["temp"]["max"]) / 2), getWind(days[3]["wind_speed"]), days[3]["humidity"].toString(), getBar(days[3]["pressure"])),
    WeatherItem(getImage(days[4]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[4]["dt"] * 1000).day.toString() + " " + month.elementAt(
    int.parse(DateTime.fromMillisecondsSinceEpoch(days[4]["dt"] * 1000).month.toString()) - 1), getTemp((days[4]["temp"]["min"] + days[4]["temp"]["max"]) / 2), getWind(days[4]["wind_speed"]), days[4]["humidity"].toString(), getBar(days[4]["pressure"])),
    WeatherItem(getImage(days[5]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[5]["dt"] * 1000).day.toString() + " " + month.elementAt(
    int.parse(DateTime.fromMillisecondsSinceEpoch(days[5]["dt"] * 1000).month.toString()) - 1), getTemp((days[5]["temp"]["min"] + days[5]["temp"]["max"]) / 2), getWind(days[5]["wind_speed"]), days[5]["humidity"].toString(), getBar(days[5]["pressure"])),
    WeatherItem(getImage(days[6]["weather"][0]["main"]), DateTime.fromMillisecondsSinceEpoch(days[6]["dt"] * 1000).day.toString() + " " + month.elementAt(
    int.parse(DateTime.fromMillisecondsSinceEpoch(days[6]["dt"] * 1000).month.toString()) - 1), getTemp((days[6]["temp"]["min"] + days[6]["temp"]["max"]) / 2), getWind(days[6]["wind_speed"]), days[6]["humidity"].toString(), getBar(days[6]["pressure"]))
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 34, 0, 0),
                      child: Text(
                        "Прогноз на неделю",
                        style: TextStyle(
                          //color: Colors.black,
                          fontFamily: "ManropeStyle",
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: height - 363,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                        child: Swiper(
                          viewportFraction: 0.9,
                          scale: 0.8,
                          itemCount: 7,
                          itemWidth: width - 40,
                          itemHeight: height - 363,
                          containerWidth: width,
                          containerHeight: height - 363,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: width - 40,
                              height: height - 363,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Theme.of(context).cardColor,
                                  Theme.of(context).highlightColor
                                ]),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Text(weathers[index].date,
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Image(
                                            height: 120,
                                            image: AssetImage(
                                                weathers[index].image)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(22, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.thermostat_outlined,
                                        //  color: Color(0xFF5A5A5A),
                                        ),
                                        Text(
                                          weathers[index]
                                              .countTemperature
                                              .toString(),
                                          style: TextStyle(
                                            //color: Colors.black,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          settings["temp"]? "°f":"°c",
                                          style: TextStyle(
                                            //color: Color(0xff5A5A5A),
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(22, 28, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.air_outlined,
                                         // color: Color(0xFF5A5A5A),
                                        ),
                                        Text(
                                          weathers[index].countWind.toString(),
                                          style: TextStyle(
                                            //color: Colors.black,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          settings["wind"]? "км/с":"м/c",
                                          style: TextStyle(
                                            //color: Color(0xff5A5A5A),
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(22, 28, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.water_outlined,
                                         //color: Color(0xFF5A5A5A),
                                        ),
                                        Text(
                                          weathers[index].countWater.toString(),
                                          style: TextStyle(
                                            //color: Colors.black,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "%",
                                          style: TextStyle(
                                            //color: Color(0xff5A5A5A),
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(22, 28, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.compress_outlined,
                                          //color: Color(0xFF5A5A5A),
                                        ),
                                        Text(
                                          weathers[index]
                                              .countPressure
                                              .toString(),
                                          style: TextStyle(
                                            //color: Colors.black,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                            settings["wind"]? "гПа":"мм.рт.ст.",
                                          style: TextStyle(
                                            //color: Color(0xff5A5A5A),
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: ElevatedButton(
                          // style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all<Color>(
                          //         Color(0xffE2EBFF)),
                          //     shape: MaterialStateProperty.all<
                          //         RoundedRectangleBorder>(
                          //         RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(10.0),
                          //             side: BorderSide(
                          //                 color: Theme.of(context).scaffoldBackgroundColor)))),
                          child: Text(
                            "Вернуться на главную",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: "ManropeStyle",
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
