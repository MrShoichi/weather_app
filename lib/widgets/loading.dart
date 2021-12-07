import 'package:flutter/material.dart';
import 'package:weather_app/theme/CustomTheme.dart';

class Loading extends StatelessWidget {
  Loading({Key key, @required this.theme}) : super(key: key);
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        title: 'Welcome to Flutter',
        home: Container(
            child: Scaffold(
                //backgroundColor: Color(0xfffE2EBFF),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("Weather",
                          style: TextStyle(
                            //color: Colors.black,
                            fontFamily: "ManropeStyle",
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,126,0,0),
                        child: Image(
                            height: 60, image: AssetImage('images/loading.gif')),
                      ),
                    ],
                  ),
                ))));
  }
}
