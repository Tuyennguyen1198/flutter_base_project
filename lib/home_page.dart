import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'library/native_view/first_widget.dart';
import 'library/native_view/second_widget.dart';
import 'library/stream_builder/home_stream_buider.dart';
import 'library/uiHelper/ui_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _iconBool = false;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;
  //----------------------------------
  List<File> listFiles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // child: Column(
        //   children: [
        //     const Text("1"),
        //     ElevatedButton(
        //       onPressed: () {
        //         getFile();
        //       },
        //       child: const Text("Hello"),
        //     ),
        //     listFiles.isNotEmpty?
        //     UIHelper.showFile("anh", context, listFiles):Container(),
        //     ElevatedButton(
        //       onPressed: () {
        //         _showToast();
        //       },
        //       child: const Text("Show Toast"),
        //     ),
        //     Text(_batteryLevel),
        //     ElevatedButton(
        //       onPressed: () {
        //         _getBatteryLevel();
        //       },
        //       child: const Text("Battery"),
        //     ),
        //
        //     // ElevatedButton(
        //     //   onPressed: () {
        //     //     Navigator.push(context,
        //     //         MaterialPageRoute(builder: (ctx) => const HomeStreamBuilDerPage()));
        //     //   },
        //     //   child: const Text("Stream data"),
        //     // ),
        //   ],
        // ),


        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[
            Card(
              child: SizedBox(
                height: 200,
                child: FirstWidget(),
              ),
            ),
            Card(
              child: SizedBox(
                height: 200,
                child: SecondWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getFile() async{
    // Get file pdf
    // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,

      // allowedExtensions: ['jpg', 'pdf', 'doc'],
      allowedExtensions: [ 'pdf'],
    );

    if (result != null) {
      // listFiles = result.paths.map((path) => File(path!)).toList();
      // print(files);
      // PlatformFile file = result.files;
      for(    PlatformFile file  in  result.files){
        if (kDebugMode) {
          print(file.path);
          print(file.name);
          print(file.extension);
        }

        // print(file.);
      }
      // for(var files in listFiles){
      //   // print(file.path.);
      //   // PlatformFile file = files as PlatformFile;
      //   print(files.path);
      //   print(files.path);
      // }
    } else {
      // User canceled the picker
    }
  }
}
