import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DialogHelper {
  static yesNoDialog(
      BuildContext context, Function confirm, String content, String title) {
// Hiển thị form nhập loại hàng
    showDialog(
        context: context,
        builder: (_) => YesNoPageDialog(
              confirm: confirm,
              text: content,
              capTitle: title,
            ));
    return;
  }
}

//class YesNoDialog {
//  static void show(BuildContext context,Function confirm, String text,String capTitle ,[String msg]){
//    showDialog(
//        context: context,
//        builder: (context) {
//          return SimpleDialog(
//            title: Text(capTitle,textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: Text(text,textAlign: TextAlign.center,),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Expanded(
//                      child: FlatButton(
//                        shape: new RoundedRectangleBorder(
//                            side: BorderSide(color: Colors.black26, width: 0.5),
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Colors.white,
//                        child: Text("Không"),
//                        onPressed: () {
//                          Navigator.of(context).pop();
//                        },
//                      ),
//                    ),
//                    SizedBox(width: 10.0,),
//                    Expanded(
////                      width: 120,
////                      height: 35,
//                      child: FlatButton(
//                        shape: new RoundedRectangleBorder(
//                            side: BorderSide(color: Colors.black26, width: 0.5),
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Colors.blue,
//                        child: Text("Có",style: TextStyle(color: Colors.white),),
//                        onPressed: () {
//                          //Navigator.of(context).pop();
//                          confirm();
////                          Navigator.of(context).pop();
//                        },
//                      ),
//                    ),
//                  ],),
//              ),
//            ],
//          );
//        });
//  }
//}
// #ignore: must_be_immutable
// ignore: must_be_immutable
class YesNoPageDialog extends StatefulWidget {
  Function confirm;
  String text;
  String capTitle;

  YesNoPageDialog(
      {super.key,
      required this.confirm,
      required this.text,
      required this.capTitle});

  @override
  _YesNoPageDialogState createState() => _YesNoPageDialogState();
}

class _YesNoPageDialogState extends State<YesNoPageDialog> {
  bool sendBool = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendBool = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        widget.capTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.blue),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
          ),
        ),
        sendBool == false
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
//                      width: 120,
//                      height: 35,
                      child: TextButton(
                        // shape: new RoundedRectangleBorder(
                        //     side: BorderSide(color: Colors.black26, width: 0.5),
                        //     borderRadius: new BorderRadius.circular(30.0)),
                        // color: Colors.white,
                        style: TextButton.styleFrom(
                            primary: Colors.red,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.black26, width: 0.5),
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text("Không"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
//                      width: 120,
//                      height: 35,
                      // ignore: deprecated_member_use
                      child: TextButton(
                        // shape: new RoundedRectangleBorder(
                        //     side: BorderSide(color: Colors.black26, width: 0.5),
                        //     borderRadius: new BorderRadius.circular(30.0)),
                        // color: Colors.blue,
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.black26, width: 0.5),
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text(
                          "Có",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          //Navigator.of(context).pop();
                          setState(() {
                            sendBool = true;
                          });
                          widget.confirm();
//                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
      ],
    );
  }
}
// import 'package:flutter/cupertino.dart';
// ignore_for_file: library_private_types_in_public_api




//import 'package:vector_math/vector_math_64.dart';
// ignore: must_be_immutable
class ShowZomImageBigDialog extends StatefulWidget {
  String image;
  int index;
  List<String> listImage;

  ShowZomImageBigDialog(
      {super.key,
        required this.image,
        required this.index,
        required this.listImage});

  @override
  _ShowZomImageBigDialogState createState() => _ShowZomImageBigDialogState();
}

class _ShowZomImageBigDialogState extends State<ShowZomImageBigDialog> {
  // double _scale = 1.0;
  // double _previousScale = 1.0;
  late int location;
  bool next = false;
  int rotatedBox = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotatedBox(
            quarterTurns: rotatedBox,
            child: PhotoView(
              imageProvider:
              // NetworkImage("${AppConfigs.apiServerImage}/${widget.image}"),
              NetworkImage("sdsa/${widget.image}"),
            ),
          ),
          Positioned(
            left: 0.0,
            top: 15.0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 28.0,
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 15.0,
            child: IconButton(
              icon: const Icon(
                Icons.navigate_next,
                color: Colors.white,
              ),
              onPressed: () {
                if (widget.listImage.length > 1) {
                  if (widget.index == widget.listImage.length) {
                    setState(() {
                      widget.index = 0;
                      widget.image = widget.listImage[widget.index++];
                    });
                  } else {
                    setState(() {
                      widget.image = widget.listImage[widget.index++];
                    });
                  }
                }
              },
              iconSize: 28.0,
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 15.0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // print(widget.index);
                // print(widget.listImage.length);
                if (widget.listImage.length > 1) {
                  if (widget.index == 0) {
//                    setState(() {
//                      widget.index = widget.listImage.length;
//                      widget.image = widget.listImage[widget.index--];
//                    });
                  } else {
//                    setState(() {
//                      widget.image = widget.listImage[widget.index--];
//                    });
                  }
//                  if(widget.index == widget.listImage.length){
//                    setState(() {
//                      widget.index = 0;
//                      widget.image = widget.listImage[widget.index++];
//                    });
//                  }
//                  else{
//                    setState(() {
//                      widget.image = widget.listImage[widget.index++];
//                    });
//                  }
                }
              },
              iconSize: 28.0,
            ),
          ),
//          Positioned(
//            bottom: 10.0,
//  //            left: 10.0,
//
//            child: IconButton(
//              icon: Icon(Icons.cached,color: Colors.white,),
//              onPressed: (){
//                setState(() {
//                  if(rotatedBox == 0 ){
//                    rotatedBox = 3;
//                  }
//                  else if(rotatedBox == 3 ){
//                    rotatedBox = 1;
//                  }
//                  else if(rotatedBox == 1 ){
//                    rotatedBox = 2;
//                  }
//                  else if(rotatedBox == 2 ){
//                    rotatedBox = 4;
//                  }
//                  else if(rotatedBox == 4 ){
//                    rotatedBox = 3;
//                  }
//                });
//              },
//              iconSize: 28.0,
//            ),
//          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.cached,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (rotatedBox == 0) {
                        rotatedBox = 3;
                      } else if (rotatedBox == 3) {
                        rotatedBox = 1;
                      } else if (rotatedBox == 1) {
                        rotatedBox = 2;
                      } else if (rotatedBox == 2) {
                        rotatedBox = 4;
                      } else if (rotatedBox == 4) {
                        rotatedBox = 3;
                      }
                    });
                  },
                  iconSize: 28.0,
                ),
//                IconButton(
//                  icon: Icon(Icons.file_download,color: Colors.white,),
//                  onPressed: (){
//                    setState(() {
//                      if(rotatedBox == 0 ){
//                        rotatedBox = 3;
//                      }
//                      else if(rotatedBox == 3 ){
//                        rotatedBox = 1;
//                      }
//                      else if(rotatedBox == 1 ){
//                        rotatedBox = 2;
//                      }
//                      else if(rotatedBox == 2 ){
//                        rotatedBox = 4;
//                      }
//                      else if(rotatedBox == 4 ){
//                        rotatedBox = 3;
//                      }
//                    });
//                  },
//                  iconSize: 28.0,
//                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
