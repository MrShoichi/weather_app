import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:weather_app/theme/CustomTheme.dart';
import 'package:weather_app/widgets/body.dart';
import 'package:weather_app/widgets/favourites_page.dart';
import 'package:weather_app/widgets/loading.dart';
import 'package:weather_app/widgets/program_page.dart';
import 'package:weather_app/widgets/settings.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map settings = {"temp": false, "wind": false, "bar": false, "load": true};
  Map theme = {"darkBackground": "images/darkTheme.png", "lightBackground": "images/sky_white.png"};
  List<String> favourites =["Санкт-Петербург"];
  DateTime currentDate;
  String favouriteCity;

  @override
  void initState() {
    favouriteCity = "Санкт-Петербург";
  }

  Future<Map<String,dynamic>> getCity() async {
    var url = await http.get(Uri.parse("http://autocomplete.travelpayouts.com/places2?term=$favouriteCity&locale=ru&types[]=city"));
    var r = jsonDecode(url.body);
    return r[0]["coordinates"];
  }
  Future<Map<String, dynamic>> func() async {
    Map<String,dynamic> coordinates = await getCity();
    String lat = coordinates["lat"].toString();
    String lon = coordinates["lon"].toString();
    var url = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&&appid=d542f2dc93eab9b9bbfb73430bdc8c29'));
    var r = jsonDecode(url.body);
    return r;
  }

  void setFavourite(String city) {
    setState((){
      favouriteCity = city;
    });
  }
  ThemeData themeData = DateTime.now().hour < 18 || DateTime.now().hour < 6 ? dark_theme: light_theme;
  @override
  Widget build(BuildContext context) {

    AssetImage assetBackground = AssetImage(themeData == dark_theme ? theme["darkBackground"] : theme["lightBackground"]);
    log(favouriteCity);
    bool openState = false;
    return FutureBuilder<Map<String, dynamic>>(
        future: func(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            settings["load"] = false;
            Map<String, dynamic> current = snapshot.data["current"];
            List<dynamic> days = snapshot.data["daily"];
            List<dynamic> hourly = snapshot.data["hourly"];
            currentDate =
                DateTime.fromMillisecondsSinceEpoch(days[0]["dt"] * 1000);
            return MaterialApp(
              theme: themeData,
              title: 'Welcome to Flutter',
              home: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: assetBackground,
                  fit: BoxFit.cover,
                )),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Body(
                    settings: settings,
                    state: setState,
                    days: days,
                    current: current,
                      hourly:hourly,
                      favourites:favourites,
                      favouriteCity: favouriteCity,
                    theme: themeData,
                  ),
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 32.0, 0, 0),
                          child: Text(
                            "Weather app",
                            style: TextStyle(
                                //color: theme,
                                fontFamily: "Manrope",
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        Builder(builder: (context) {
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(22.6, 40.0, 0, 0),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Settings(
                                        settings: settings, state: setState)));
                              },
                              title: const Text("Настройки",
                                  style: TextStyle(
                                      fontFamily: "ManropeStyle",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18)),
                              leading: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(
                                  Icons.settings_outlined,
                                  //color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 32.0, 0, 0),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FavouritesPage(setCity: setFavourite, favouriteCity: favouriteCity, favourites: favourites, state: setState,)));
                              },
                              title: const Text("Избранное",
                                  style: TextStyle(
                                      fontFamily: "ManropeStyle",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18)),
                              leading: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20.63, 0),
                                child: Icon(
                                  Icons.favorite_outline,
                                  //color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 32.0, 0, 0),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProgramPage()));
                              },
                              title: const Text("О приложении",
                                  style: TextStyle(
                                    fontFamily: "ManropeStyle",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  )),
                              leading: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20.5, 0),
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  //color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            settings["load"] = true;
            return Loading(theme: themeData);
          }
        });
  }
}
