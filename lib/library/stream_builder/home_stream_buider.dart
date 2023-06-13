import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/library/api/create_order_api.dart';
import 'package:http/http.dart' as http;

class HomeStreamBuilDerPage extends StatefulWidget {
  const HomeStreamBuilDerPage({Key? key}) : super(key: key);

  @override
  State<HomeStreamBuilDerPage> createState() => _HomeStreamBuilDerPageState();
}

class _HomeStreamBuilDerPageState extends State<HomeStreamBuilDerPage> {
  StreamController<List<DataModel>> _streamController = StreamController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // getData();
      getDataS();
    });
    // getDataS();
  }

  List<DataModel> list = [];

  Future<void> getData() async {
    var url = Uri.parse(
        'http://192.168.1.117:8080/tkc/public/api/getMessageChatMobile');
    final reponse = await http.get(url);
    List dataBody = json.decode(reponse.body);
    list = dataBody.map((json) => DataModel.fromJson(json)).toList();
    _streamController.add(list);
  }

  Future getDataS() async {
    list = [];
    CreateOrderApi.getMessageChatMobile().then((result) async {
//      LoadingDialog.dismiss(context);
      if (!result.isStatus!) {
        // MessageDialog.show(context, result.message);
        return;
      }
      List data = [];
      data = result.data["data"];
      log(data.toString());
      if (result.data.toString() != "[]") {
        for (int i = 0; i < data.length; i++) {
          // setState(() {
            list.add(DataModel(
              id: data[i]["id"],
              fromId: data[i]["fromId"],
              msg: data[i]["msg"],
              sent: data[i]["sent"],
              to: data[i]["to"],
              type: data[i]["type"],
            ));
          // });
        }
      }
      log(list.length.toString());
      // MessageDialog.show(context, result.message, '', () {
      //   Navigator.of(context).pop();
      //   Navigator.of(context).pop();
      //   widget.function!();
      // });
    }).catchError((err) {
      // MessageDialog.show(context, TrangKhanhString.connectToServerFailed);
    });
    // List dataSS =dataS;
    // for(int i =0; i < dataS.leght ;i++){
    //   log(dataS[i]['id']);
    // }
    // list = dataBody.map((json) => DataModel.fromJson(json) ).toList();
    _streamController.add(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stream Builder"),
      ),
      body: StreamBuilder<List<DataModel>>(
        stream: _streamController.stream,
        // initialData: ,
        builder: (context, snapData) {
          switch (snapData.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return Text("donet");
            default:
              if (snapData.hasError) {
                return const Text("Please Wait");
              } else {
                return ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      DataModel dataModel = snapData.data![index];
                      return Text(dataModel.id!);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: list.length);
              }
          }
        },
      ),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class DataModel {
  String? id;
  String? fromId;
  String? msg;
  String? sent;
  String? to;
  String? name;
  String? type;

  DataModel(
      {this.id,
      this.name,
      this.msg,
      this.sent,
      this.fromId,
      this.to,
      this.type});

  DataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        fromId = json['fromId'] ?? '',
        msg = json['msg'] ?? '',
        sent = json['sent'] ?? '',
        to = json['to'] ?? '',
        name = json['name'] ?? '';

  // a method that convert
  Map<String, dynamic> toJson() => {
        'id': id,
        'fromId': fromId,
        'msg': msg,
        'sent': sent,
        'to': to,
        'name': name,
      };
}
