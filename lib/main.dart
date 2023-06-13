import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/library/stream_builder/home_stream_buider.dart';
import 'package:flutter_base_project/library/uiHelper/ui_helper.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Change data true false for icon
  bool _iconBool = false;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;

// Change color theme
  ThemeData themeDataLight() {
    return ThemeData(
      primarySwatch: Colors.amber,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.amberAccent),
    );
  }

  ThemeData themeDataDark() {
    return ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(color: Colors.blue, centerTitle: true),
        brightness: Brightness.dark);
  }

//----------------------------------
  List<File> listFiles = [];
  // Run channel
  static const channel = MethodChannel('com.example.flutter_base_project/show');
  static const platform = MethodChannel('samples.flutter.dev/battery');
///
  /// Get battery level.
  String _batteryLevel = 'Unknown battery level.';


  @override
  Widget build(BuildContext context) {
    // var curlScale = MediaQuery.of(context).textScaleFactor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 2sda',
      theme: _iconBool ? themeDataDark() : themeDataLight(),
      // supportedLocales: ,

      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dark & Light Theme"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _iconBool = !_iconBool;
                  });
                },
                icon: Icon(_iconBool ? _iconDark : _iconLight))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Text("1"),
              ElevatedButton(
                onPressed: () {
                },
                child: const Text("Hello"),
              ),
              listFiles.isNotEmpty?
                  UIHelper.showFile("anh", context, listFiles):Container(),
              ElevatedButton(
                onPressed: () {
                    _showToast();
                },
                child: const Text("Show Toast"),
              ),
              Text(_batteryLevel),
              ElevatedButton(
                onPressed: () {
                  _getBatteryLevel();
                },
                child: const Text("Battery"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const HomeStreamBuilDerPage()));
                },
                child: const Text("Stream data"),
              ),
            ],
          ),
        ),
      ),

      // home: const HomePage(),
    );
  }

  Future<void> _showToast() async {
    final int showtoast = await channel.invokeMethod('showtoast',<String,String>{
      'msg':"This is toast from Flutter to Android Native"
    });
  }
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

}
