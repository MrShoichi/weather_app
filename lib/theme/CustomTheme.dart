import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


ThemeData light_theme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    accentColor: Color(0xff038CFE),
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    primaryColorLight: Color(0x1a311F06),
    cardColor: Color(0xffcddaf5),
    highlightColor: Color(0xff9cbcff),
    primaryColorDark: Colors.black,
    canvasColor: Color(0xffe2ebff),
    scaffoldBackgroundColor: Color(0xffe2ebff),
    bottomAppBarColor: Color(0xffc8daff),
    cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.black,
            primaryContrastingColor: Colors.white
    ),
    buttonTheme: ButtonThemeData(buttonColor: Color(0xff038CFE)),
    iconTheme: IconThemeData(
        color: Colors.black
    ),


    platform: TargetPlatform.android,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    applyElevationOverlayColor: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0xffe2ebff)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Color(0xff038CFE)))))),
    pageTransitionsTheme: PageTransitionsTheme(
        //page transition theme
    ),
    appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
        // bottom app bar theme
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: Color(0xff4b5f88),
        fillColor: Color(0xffe2ebff)
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0xffe2ebff),
        modalBackgroundColor: Color(0xff038CFE),


    ),
    popupMenuTheme: PopupMenuThemeData(
        //pop menu theme
    ),
    bannerTheme: MaterialBannerThemeData(
        // material banner theme
    ),
    dividerTheme: DividerThemeData(
        //divider, vertical divider theme
    ),
    buttonBarTheme: ButtonBarThemeData(
        // button bar theme
    ),
    fontFamily: 'ROBOTO',
    splashFactory: InkSplash.splashFactory
);




ThemeData dark_theme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),

    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: Color(0x1a311F06),
    cardColor: Color(0xff223b70),
    highlightColor: Color(0xff0f1f40),
    primaryColorDark: Colors.black,
    canvasColor: Color(0xff071427),
    scaffoldBackgroundColor: Color(0xff0d172b),
    bottomAppBarColor: Color(0xff152a53),
    accentColor: Colors.white,
    buttonTheme: ButtonThemeData(buttonColor: Colors.white),
    iconTheme: IconThemeData(
color: Colors.white
        ),
    cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.white,
        primaryContrastingColor: Colors.black
    ),

    platform: TargetPlatform.android,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    applyElevationOverlayColor: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff0d182c)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.white))))),
    pageTransitionsTheme: PageTransitionsTheme(
        //page transition theme
        ),
    appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        ),
    bottomAppBarTheme: BottomAppBarTheme(
        // bottom app bar theme
        ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff071427),
      modalBackgroundColor: Colors.white,


    ),
    popupMenuTheme: PopupMenuThemeData(
        //pop menu theme
        ),
    bannerTheme: MaterialBannerThemeData(
        // material banner theme
        ),
    dividerTheme: DividerThemeData(
        //divider, vertical divider theme
        ),
    buttonBarTheme: ButtonBarThemeData(
        // button bar theme
        ),
    splashFactory: InkSplash.splashFactory,
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: Color(0xff0e182c),
        fillColor: Colors.white
    ),
);
