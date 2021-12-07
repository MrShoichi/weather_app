import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'add_favourites_page.dart';
import 'package:http/http.dart' as http;

import 'loading.dart';

class Head extends StatelessWidget {
  Head(
      {Key key,
      this.openState = false,
      @required this.settings,
      @required this.current,
        @required this.favourites,
      @required this.favouriteCity,
      @required this.theme})
      : super(key: key);
  final Map settings;
  final ThemeData theme;
  final Map<String, dynamic> current;
  final List<String> favourites;
  final String favouriteCity;
  int getTemp(double Kelvin) {
    if (!settings["temp"]) {
      return (Kelvin - 273.15).round();
    } else {
      return ((Kelvin - 273.15) * 9 / 5 + 32).round();
    }
  }

  Set<String> month = {
    "янв.",
    "фев.",
    "мар.",
    "апр.",
    "май.",
    "июн.",
    "июл.",
    "авг.",
    "сен.",
    "окт.",
    "нояб.",
    "дек."
  };
  final bool openState;

  @override
  Widget build(BuildContext context) {

    String temp = settings['temp'] ? "°F" : "°C";
    String wind = settings['wind'] ? "км/c" : "м/c";
    String bar = settings['bar'] ? "гПа" : "мм.рт.ст";
    DateTime currentDate;
    currentDate = DateTime.fromMillisecondsSinceEpoch(current["dt"] * 1000);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 30,
          color: Theme.of(context).appBarTheme.foregroundColor,
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Column(children: [
          Visibility(
            visible: openState,
            child: Text(
              favouriteCity,
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontFamily: "ManropeStyle",
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            getTemp(current["temp"]).toString() + temp,
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
              fontFamily: "ManropeStyle",
              fontWeight: FontWeight.w600,
              fontSize: 80,
            ),
          ),
          Visibility(
            visible: !openState,
            child: Text(
              currentDate.day.toString() +
                  " " +
                  month.elementAt(int.parse(currentDate.month.toString()) - 1) +
                  " " +
                  currentDate.year.toString(),
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontFamily: "ManropeStyle",
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ]),
        Builder(builder: (context) {
          return IconButton(
              iconSize: 30,
              color: Theme.of(context).appBarTheme.foregroundColor,
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddFavouritesPage(favourites: favourites, theme: theme )));
              });
        }),
      ],
    );
  }
}
