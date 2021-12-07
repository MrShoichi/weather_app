import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;

import 'loading.dart';

class AddFavouritesPage extends StatefulWidget {
  const AddFavouritesPage({Key key, @required this.favourites, @required this.theme})
      : super(key: key);
  final List<String> favourites;
  final ThemeData theme;
  @override
  State<AddFavouritesPage> createState() => _AddFavouritesPageState();
}

class _AddFavouritesPageState extends State<AddFavouritesPage> {
  Future<Map<String, dynamic>> loadJsonData() async {
    var response = await rootBundle.loadString('assets/cities.json');
    log(response);
    var r = jsonDecode(response);
    return r;
  }

  Map<String, bool> data;
  Map<String, bool> cities;
  TextEditingController txtQuery = TextEditingController();
  void update(String query) {
    List<String> newData = data.keys.toList();
    data = {for (var e in newData) e: widget.favourites.contains(e)};
    search(query);
  }

  void search(String query) {
    if (query.isEmpty) {
      cities = data;
      setState(() {});
      return;
    }
    query = query.toLowerCase();
    Map<String, bool> result = new Map();
    log(widget.favourites.toString());
    data.forEach((p, v) {
      var name = p.toString().toLowerCase();
      if (name.contains(query)) {
        result.putIfAbsent(p, () => v);
      }
    });

    cities = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> sortList = snapshot.data["city"];
            sortList.sort(((a, b) => a["name"].compareTo(b["name"])));

            data = {for (var e in sortList) e["name"].toString(): widget.favourites.contains(e["name"].toString())};

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.arrow_back_ios),
                                      onPressed: () =>
                                          Navigator.of(context).pop()),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      height: 33,
                                      child: CupertinoTextField(
                                          controller: txtQuery,
                                          onChanged: search,
                                          placeholderStyle: (TextStyle(
                                            color: Theme.of(context).cupertinoOverrideTheme.primaryColor,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          )),

                                          decoration: BoxDecoration(
                                           // color: Color(0xfffE2EBFF),
                                          ),
                                          style: TextStyle(
                                            color: Theme.of(context).cupertinoOverrideTheme.primaryColor,
                                            fontFamily: "ManropeStyle",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                          placeholder:
                                              "Введите название города...",
                                          suffix: ClipOval(
                                            child: Material(
                                              color: Theme.of(context).cupertinoOverrideTheme.primaryColor,
                                              // Button color
                                              child: InkWell(
                                                splashColor: Theme.of(context).cupertinoOverrideTheme.primaryContrastingColor,
                                                // Splash color
                                                onTap: () {
                                                  txtQuery.clear();
                                                  search("");
                                                },
                                                child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Theme.of(context).cupertinoOverrideTheme.primaryContrastingColor,
                                                    )),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListViewCity(cities: cities, favourites: widget.favourites, state: update, query: txtQuery.text)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading(theme: widget.theme,);
          }
        });
  }
}
class ListViewCity extends StatefulWidget  {
  final Map<String,bool> cities;
  final List<String> favourites;
  final void Function(String query) state;
  final String query;
  const ListViewCity({Key key,@required this.cities,@required this.favourites,@required this.state, @required this.query}) : super(key: key);

  @override
  State<ListViewCity> createState() => _ListViewCityState();
}

class _ListViewCityState extends State<ListViewCity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height - 140,
            child: ListView.builder(
                itemCount: widget.cities == null ? 0 : widget.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  var name = widget.cities.keys.elementAt(index);
                  var exists = widget.cities.values.elementAt(index);
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(name),
                              IconButton(
                                icon: exists
                                    ? Icon(Icons.star)
                                    : Icon(Icons.star_border),
                                onPressed: () {
                                  if (!widget.favourites.contains(name)) {

                                    widget.favourites.add(name);
                                  } else {
                                    widget.favourites.remove(name);
                                  }
                                  widget.state(widget.query);
                                },
                              ),
                            ]),
                      ),
                      const Divider(),
                    ],
                  );
                })));
  }
}
