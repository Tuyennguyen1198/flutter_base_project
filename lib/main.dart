import 'package:flutter/material.dart';

void main() {
  runApp( const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Change data true false for icon
  bool _iconBool = false;
  final IconData _iconLight  = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;

// Change color theme
  ThemeData themeDataLight(){
    return ThemeData(
      primarySwatch: Colors.amber,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: true,

      ),
      buttonTheme: const ButtonThemeData(
          buttonColor: Colors.amberAccent
      ),
    );
  }

  ThemeData themeDataDark(){
   return ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
            color: Colors.blue,
            centerTitle: true
        ),
        brightness: Brightness.dark
    );
  }
//----------------------------------

  @override
  Widget build(BuildContext context) {
    // var curlScale = MediaQuery.of(context).textScaleFactor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 2sda',
      theme: _iconBool ? themeDataDark() :themeDataLight(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dark & Light Theme"),
          actions: [
            IconButton(onPressed: (){
              setState((){
                _iconBool =!_iconBool;
              });
            }, icon: Icon(_iconBool?_iconDark :_iconLight))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Text("1"),
              ElevatedButton(
                onPressed: (){

                },
                child: const Text("Hello"),

              )
            ],
          ),
        ),
      ),
    );
  }
}


