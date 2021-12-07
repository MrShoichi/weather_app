import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Settings extends StatefulWidget {
  const Settings({Key key, @required this.settings, @required this.state}) : super(key: key);
  final Map settings;
  final void Function(VoidCallback fn) state;
  @override
  State<Settings> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.settings["temp"] ? 1 : 0;
    int _selectedPressureIndex = widget.settings["bar"] ? 1 : 0;
    int _selectedWindIndex = widget.settings["wind"] ? 1 : 0;
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
                              onPressed: (){
                                  widget.state((){

                                  });
                                  Navigator.of(context).pop();
                              }),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(33, 0, 0, 0),
                            child: Text(
                              "Настройки",
                              style: TextStyle(
                               // color: Colors.black,
                                fontFamily: "ManropeStyle",
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 32, 0, 0),
                          child: Text(
                            "Единицы измерения",
                            style: TextStyle(
                              //color: Color(0xff828282),
                              fontFamily: "ManropeStyle",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Container(
                          child: Neumorphic(
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(30)),
                                depth: 4,
                                intensity: 0.5,
                                lightSource: LightSource.top,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            "Температура",
                                            style: TextStyle(
                                              //color: Colors.black,
                                              fontFamily: "ManropeStyle",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            30)),
                                                depth: 6,
                                                intensity: 0.8,
                                                lightSource: LightSource.top,
                                                color: Theme.of(context).scaffoldBackgroundColor,
                                              ),
                                              child: NeumorphicToggle(
                                                height: 30,
                                                width: 130,
                                                style:
                                                     NeumorphicToggleStyle(
                                                  disableDepth: true,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  backgroundColor:
                                                  Theme.of(context).toggleButtonsTheme.fillColor,
                                                ),
                                                displayForegroundOnlyIfSelected:
                                                    true,
                                                thumb: Neumorphic(
                                                  style: NeumorphicStyle(
                                                      shape:
                                                          NeumorphicShape.flat,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      depth: 8,
                                                      intensity: 0.8,
                                                      lightSource:
                                                          LightSource.topLeft,
                                                      color: Theme.of(context).toggleButtonsTheme.color),
                                                ),
                                                selectedIndex: _selectedIndex,
                                                onChanged: (value) {
                                                  setState((){
                                                    widget.settings["temp"] =
                                                        value == 1;
                                                    _selectedIndex = value;
                                                  });
                                                  widget.state((){

                                                  });

                                                },
                                                children: [
                                                  ToggleElement(
                                                    background:  Center(
                                                        child: Text(
                                                      "°C",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                      color: Theme.of(context).primaryColorDark),
                                                    )),
                                                    foreground:  Center(
                                                        child: Text(
                                                      "°С",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    )),
                                                  ),
                                                  ToggleElement(
                                                    background:  Center(
                                                        child: Text(
                                                      "°F",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                      color: Theme.of(context).primaryColorDark),
                                                    )),
                                                    foreground: Center(
                                                        child: Text(
                                                      "°F",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 16, 0, 0),
                                          child: Container(
                                            height: 1.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            color:
                                                Colors.black.withOpacity(0.15),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 16, 0, 0),
                                            child: Text(
                                              "Сила Ветра",
                                              style: TextStyle(
                                                //color: Colors.black,
                                                fontFamily: "ManropeStyle",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 16, 20, 0),
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            30)),
                                                depth: 6,
                                                intensity: 0.8,
                                                lightSource: LightSource.top,
                                                color: const Color(0xffe2ebff),
                                              ),
                                              child: NeumorphicToggle(
                                                height: 30,
                                                width: 130,
                                                style:
                                                    NeumorphicToggleStyle(
                                                  disableDepth: true,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  backgroundColor:
                                                   Theme.of(context).toggleButtonsTheme.fillColor,
                                                ),
                                                displayForegroundOnlyIfSelected:
                                                    true,
                                                thumb: Neumorphic(
                                                  style: NeumorphicStyle(
                                                      shape:
                                                          NeumorphicShape.flat,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      depth: 8,
                                                      intensity: 0.8,
                                                      lightSource:
                                                          LightSource.topLeft,
                                                      color: Theme.of(context).toggleButtonsTheme.color),
                                                ),
                                                selectedIndex:
                                                    _selectedWindIndex,
                                                onChanged: (value) {
                                                  setState((){
                                                    widget.settings["wind"] =
                                                        value == 1;
                                                    _selectedWindIndex = value;
                                                  });
                                                  widget.state((){

                                                  });

                                                },
                                                children: [
                                                  ToggleElement(
                                                    background: Center(
                                                        child: Text(
                                                      "м/c",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Theme.of(context).primaryColorDark),
                                                    )),
                                                    foreground: Center(
                                                        child: Text(
                                                      "м/c",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    )),
                                                  ),
                                                  ToggleElement(
                                                    background:  Center(
                                                        child: Text(
                                                      "км/c",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                      color: Theme.of(context).primaryColorDark),
                                                    )),
                                                    foreground: const Center(
                                                        child: Text(
                                                      "км/c",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 16, 0, 0),
                                          child: Container(
                                            height: 1.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            color:
                                                Colors.black.withOpacity(0.15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 16, 0, 0),
                                            child: Text(
                                              "Давление",
                                              style: TextStyle(
                                                //color: Colors.black,
                                                fontFamily: "ManropeStyle",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 16, 20, 0),
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            30)),
                                                depth: 6,
                                                intensity: 0.8,
                                                lightSource: LightSource.top,
                                                color: const Color(0xffe2ebff),
                                              ),
                                              child: NeumorphicToggle(
                                                height: 30,
                                                width: 130,
                                                style:
                                                    NeumorphicToggleStyle(
                                                  disableDepth: true,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  backgroundColor:
                                                  Theme.of(context).toggleButtonsTheme.fillColor,
                                                ),
                                                displayForegroundOnlyIfSelected:
                                                    true,
                                                thumb: Neumorphic(
                                                  style: NeumorphicStyle(
                                                      shape:
                                                          NeumorphicShape.flat,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      depth: 8,
                                                      intensity: 0.8,
                                                      lightSource:
                                                          LightSource.topLeft,
                                                      color: Theme.of(context).toggleButtonsTheme.color),
                                                ),
                                                selectedIndex:
                                                    _selectedPressureIndex,
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.settings["bar"] =
                                                        value == 1;
                                                    _selectedPressureIndex =
                                                        value;
                                                  });
                                                  widget.state((){

                                                  });
                                                },
                                                children: [
                                                  ToggleElement(
                                                    background:  Center(
                                                        child: Text(
                                                      "мм.рт.ст",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Theme.of(context).primaryColorDark),
                                                    )),
                                                    foreground: Center(
                                                        child: Text(
                                                      "мм.рт.ст",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    )),
                                                  ),
                                                  ToggleElement(
                                                    background:  Center(
                                                        child: Text(
                                                      "гПа",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Theme.of(context).primaryColorDark),
                                                    )),
                                                    foreground: Center(
                                                        child: Text(
                                                      "гПа",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                ),
                              ))),
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
