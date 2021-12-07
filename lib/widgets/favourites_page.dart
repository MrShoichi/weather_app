import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage(
      {Key key,
      @required this.setCity,
      @required this.favouriteCity,
      @required this.favourites,
      @required this.state})
      : super(key: key);
  final List<String> favourites;
  String favouriteCity;
  final void Function(String fn) setCity;
  final void Function(VoidCallback fn) state;

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              onPressed: () => Navigator.of(context).pop()),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(33, 0, 0, 0),
                            child: Text(
                              "Избранные",
                              style: TextStyle(
                                //color: Colors.black,
                                fontFamily: "ManropeStyle",
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                      child: Container(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height - 172,
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListView.builder(
                                itemCount: widget.favourites == null
                                    ? 0
                                    : widget.favourites.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  String name = widget.favourites[index];
                                  return Column(
                                    children: <Widget>[
                                      Neumorphic(
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.convex,
                                          boxShape: NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(10)),
                                          depth: -1,
                                          intensity: 0.7,
                                          surfaceIntensity: 0.1,
                                          lightSource: LightSource.topRight,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                        ),
                                        child: ListTile(
                                          title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 0, 0, 0),
                                                  child: Text(name),
                                                ),
                                                Neumorphic(

                                                  style: NeumorphicStyle(

                                                    shape: NeumorphicShape.flat,
                                                    boxShape: NeumorphicBoxShape
                                                        .roundRect(BorderRadius
                                                            .circular(10)),
                                                    depth: 0,
                                                    intensity: 0.9,
                                                    lightSource:
                                                        LightSource.topLeft,
                                                    color:Theme.of(context).bottomAppBarColor,
                                                  ),

                                                  child: Container(
                                                    width: 55,
                                                    height: 55,
                                                    child: IconButton(

                                                      iconSize: 25,
                                                        icon: Icon(Icons.close_outlined),
                                                      onPressed: () {
                                                          widget.favourites.remove(name);
                                                          setState((){});
                                                      },
                                                        ),
                                                  ),

                                                )
                                              ]),
                                          onTap: () {
                                            widget.setCity(name);
                                            Navigator.of(context).pop();
                                          },

                                          contentPadding: EdgeInsets.zero,
                                          minVerticalPadding: 0,
                                        ),
                                      ),
                                      const Divider(color: Colors.transparent),
                                    ],
                                  );
                                })),
                      ),
                    )
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
