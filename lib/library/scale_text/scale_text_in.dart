import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/library/dialog/dialog.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../color/color.dart';
import '../sizeBox/size_box.dart';
import '../uiHelper/ui_helper.dart';

class ScaleText extends StatefulWidget {
  const ScaleText({Key? key}) : super(key: key);

  @override
  State<ScaleText> createState() => _ScaleTextState();
}

class _ScaleTextState extends State<ScaleText> {
  List<String> listImageUpdate = [];

  File? _image;

  // Future getImage() async {
  //   // ignore: deprecated_member_use
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = image;
  //   });
  //   // sendImageToServer(_image!);
  // }
  // _openGallery() async {
  //   var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   this.setState(() {
  //     setState(() {
  //       print(picture.path);
  //       _image = picture;
  //       sendImageToServer(_image);
  //     });
  //   });
  // }
  Future getImagesAlbum() async {
    // files.clear();
    List<Asset> resultList = [];
    resultList = await MultiImagePicker.pickImages(
      maxImages: 50,
      enableCamera: false,
    );
    for (var asset in resultList) {
      int maxWidth = 1000; //keep ratio
      int height =
          ((1000 * asset.originalHeight!) / asset.originalWidth!).round();
      // ignore: deprecated_member_use
      ByteData byteData =
          await asset.requestThumbnail(maxWidth, height, quality: 80);
      if (byteData != null) {
        // // print(byteData);
        // // List<int> imageData = byteData.buffer.asUint8List();
        // // UploadFileInfo u = UploadFileInfo.fromBytes(imageData, asset.name);
        // // files.add(u);
        // print(base64.encode(byteData.buffer.asUint8List()));

        // sendImageToServers(base64.encode(byteData.buffer.asUint8List()));
      }
    }
  }

  // sendImageToServers(String picture) async {
  //   SendImage.sendImageToServer(picture, 1).then((result) async {
  //     if (!result.isStatus!) {
  //       MessageDialog.show(context, result.message);
  //       return;
  //     }
  //     setState(() {
  //       listImageUpdate.add(result.data);
  //     });
  //   }).catchError((err) {
  //     MessageDialog.show(context, TrangKhanhString.connectToServerFailed);
  //   });
  // }
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQueryData.copyWith(
            textScaleFactor: mediaQueryData.textScaleFactor.clamp(
                TrangKhanhColors.textScaleFactorLimit,
                TrangKhanhColors.textScaleFactorHeight)),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Cập nhật chi phí',
              style: TextStyle(fontSize: 17.0),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizeBoxHelper.sizedBoxWidth("Nhân viên"),
                            const Expanded(
                              child: Text("1231"),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizeBoxHelper.sizedBoxWidth("Nhân viên"),
                             Expanded(
                              child: TextFormField(
                                focusNode: usernameFocusNode,
                                onFieldSubmitted: (text) {
                                  UIHelper.changeControlFocus(context,
                                      usernameFocusNode, passwordFocusNode);
                                },
                                // Format số nhập vào
                                inputFormatters: [
                                  // FilteringTextInputFormatter.digitsOnly
                                  // Giới hạn số nhập vào
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                  CurrencyInputTFormatter()
                                ],
                                textAlign: TextAlign.start,
                                // Thiết kế sao cho khung nhập dữ liệu là bé nhất
                                decoration: InputDecoration(
                                    hintText: "Note",
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        top: 5.0, left: 0.0, right: 10.0,bottom: 5),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.grey)),
                                validator: (value) {
                                  // if (value == null || value == '0') {
                                  if (value == null || value.isEmpty) {
                                    return "Please input valid amount";
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: ElevatedButton(
                              onPressed: (){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content:Text( "Wallet was deleted")));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).backgroundColor,

                              ),
                              child: const Text("Button"),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0.0,
                  child: Column(
                    children: const [],
                  ),
                ),
                listImageUpdate.isNotEmpty
                    ? UIHelper.showImage("Ảnh", context, listImageUpdate)
                    : Container(),
                Card(
                  elevation: 0.0,
                  shape: UIHelper.getShapeCard(0.1, 0.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        children: <Widget>[
                          const Text("Chọn hiển thị"),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Tooltip(
                                message: "Chụp ảnh",
                                child: IconButton(
                                  onPressed: () {
                                    // getImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: "Lấy ảnh từ thư viện",
                                child: IconButton(
                                  splashColor: Colors.pink,
                                  onPressed: () {
                                    // _openGallery();
                                    getImagesAlbum();
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                // Column(
                //   children: listCardDetailPlanTaskPage,
                // ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 35.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: getDesignFlatButton(
                      color: Colors.red,
                      text: "Quay lại",
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                const SizedBox(
                  width: 1.0,
                ),
                Expanded(
                  child: getDesignFlatButton(
                      color: Colors.blue,
                      text: "Lưu",
                      textColor: Colors.white,
                      onPressed: () {
                        DialogHelper.yesNoDialog(
                            context, () {}, "Duyệt phiếu ", "Thông báo !");
                      }),
                )
              ],
            ),
          ),
          backgroundColor: TrangKhanhColors.background,
        ));
  }
}

class getDesignFlatButton extends StatefulWidget {
  Color? color;
  Color? textColor;
  Function? onPressed;
  String? text;
  Color? splashColor;
  final padding;

  getDesignFlatButton({
    Key? key,
    this.onPressed,
    this.textColor,
    this.splashColor,
    this.padding,
    this.color,
    this.text,
  }) : super(key: key);

  @override
  State<getDesignFlatButton> createState() => _getDesignFlatButtonState();
}

class _getDesignFlatButtonState extends State<getDesignFlatButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: widget.color,
        textStyle: TextStyle(color: widget.textColor),
        padding: widget.padding ?? const EdgeInsets.all(3.0),
        // elevation: 5.0
      ),
      onPressed: () {
        // print(1);
        widget.onPressed!();
      },
      child: Text(
        widget.text!,
        style: TextStyle(fontSize: 14.0, color: widget.textColor),
      ),
    );
  }
}
