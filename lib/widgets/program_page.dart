
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({Key key}) : super(key: key);

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
                              "О разработчике",
                              style: TextStyle(
                                //color: Colors.black,
                                fontFamily: "ManropeStyle",
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(69, 80, 67, 0),
                      child: Neumorphic(
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                            depth: -2,
                            intensity: 0.6,

                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: const SizedBox(
                            width: 224,
                            height: 52,
                            child: Center(
                              child: Text(
                                "WeatherApp",
                                style: TextStyle(
                                 // color: Colors.black,
                                  fontFamily: "ManropeStyle",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 108, 0, 0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(30)),
                          depth: 10,
                          intensity: 0.6,
                          lightSource: LightSource.bottom,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight:
                              MediaQuery.of(context).size.height - 358),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 23, 0, 0),
                                      child: Text(
                                        "by ITMO University",
                                        style: TextStyle(
                                         // color: Colors.black,
                                          fontFamily: "ManropeStyle",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(
                                        "Версия 1.0",
                                        style: TextStyle(
                                          //color: Color(0xfff4A4A4A),
                                          fontFamily: "ManropeStyle",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(
                                        "от 30 сентября 2021",
                                        style: TextStyle(
                                          //color: Color(0xfff4A4A4A),
                                          fontFamily: "ManropeStyle",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(
                                  "2021",
                                  style: TextStyle(
                                    //color: Colors.black,
                                    fontFamily: "ManropeStyle",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
