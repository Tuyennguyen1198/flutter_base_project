import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_file/internet_file.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';
import '../dialog/dialog.dart';

class UIHelper{

  static void changeControlFocus(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    if (currentFocus.hasFocus) currentFocus.unfocus();

    FocusScope.of(context).requestFocus(nextFocus);
  }

  static RoundedRectangleBorder getShapeCard(double sizeWidth,
      double circular) {
    return RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: sizeWidth),
      borderRadius: BorderRadius.circular(circular),
    );
  }

  static Widget showImage(String content, BuildContext context,
      List<String> listReceipt) {
    return Column(
      children: <Widget>[
        Text("$content${listReceipt.length} ảnh"),
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height - 150,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listReceipt.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0.0,
                  shape: UIHelper.getShapeCard(0.1, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 150,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 30.0,
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                              '23'
                              // "${AppConfigs
                              //     .apiServerImage}${listReceipt[index]}",

                              // loadingBuilder: (BuildContext context,
                              //     Widget child,
                              //     ImageChunkEvent loadingProgress) {
                              //   if (loadingProgress == null) return child;
                              //   return Center(
                              //     child: CircularProgressIndicator(
                              //       value: loadingProgress.expectedTotalBytes !=
                              //               null
                              //           ? loadingProgress
                              //                   .cumulativeBytesLoaded /
                              //               loadingProgress.expectedTotalBytes
                              //           : null,
                              //     ),
                              //   );
                              // },
                              ,
                              fit: BoxFit.fill,
                            ),
                          ),
                          onTap: () {
//                                      ShowZoomImageDialog
//                                          .show(
//                                          context,
//                                          listImage[
//                                          index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShowZomImageBigDialog(
                                        image: listReceipt[index],
                                        index: index,
                                        listImage: listReceipt,
                                      )),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
  static Widget showPDF(String content, BuildContext context,
      List<String> listPdf) {

    // AppConfigs.apiServerImage+"/"+listPdf[index]

    return Column(
      children: <Widget>[
        Text("$content${listPdf.length} file PDF"),
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height - 150,
          // height: 300.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listPdf.length,
              itemBuilder: (context, index) {
                // print(listPdf[index]);
                return Card(
                  elevation: 0.0,
                  shape: UIHelper.getShapeCard(0.1, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  <Widget>[
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 150,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 30.0,
                        child: GestureDetector(
                          child:   Padding(
                            padding: const EdgeInsets.all(5.0),
                            // child: PDfViewPageMobile(link: listPdf[index],),
                            // child:PDFView(
                            //   filePath: listPdf[index],
                            //   enableSwipe: true,
                            //   swipeHorizontal: true,
                            //   autoSpacing: false,
                            //   pageFling: false,
                            //   onRender: (_pages) {
                            //     // setState(() {
                            //     //   pages = _pages;
                            //     //   isReady = true;
                            //     // });
                            //   },
                            //   onError: (error) {
                            //     print(error.toString());
                            //   },
                            //   onPageError: (page, error) {
                            //     print('$page: ${error.toString()}');
                            //   },
                            //   onViewCreated: (PDFViewController pdfViewController) {
                            //     // _controller.complete(pdfViewController);
                            //   },
                            //   onPageChanged: (int? page, int? total) {
                            //     // print('page change: $page/$total');
                            //   },
                            // ),
                            // child: Text(""),
                            child: ShowPDF2(path:listPdf[index] ),
                          ),
                          onTap: () {
//                                    _launchURL(AppConfigs
//                                        .apiServerImage+"/"+listPdf[index]);
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(builder: (context) => ShowZomImageBigDialog(image: listImage[
//                                      index],index: index,listImage: listImage,)),
//                                    );
                          },
                        ),
                      ),
                      // PDFView(
                      //
                      // )
                    ],
                  ),
                );

                // return  ShowPDF2(path:listPdf[index] ,);
              }),
        ),

        // SizedBox(
        //   width: MediaQuery
        //       .of(context)
        //       .size
        //       .width,
        //   height: MediaQuery
        //       .of(context)
        //       .size
        //       .height - 150,
        //
        //   child: Text(docText),
        // ),
      ],
    );
  }
}
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// ignore_for_file: must_be_immutable


// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class ShowPDF2 extends StatefulWidget {
  String? path;
  ShowPDF2({Key? key,this.path}) : super(key: key);

  @override
  State<ShowPDF2> createState() => _ShowPDF2State();
}

class _ShowPDF2State extends State<ShowPDF2> {
  // bool _isLoading = true;
  // PDFDocument? document;
  String docText ='';
  String data = '';
  // var pdfController;
  late PdfController _pdfController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isLoading = false;
    // print(widget.path);

    // docText = AppConfigs.apiServerImage+ widget.path!;
    docText = "21212"+ widget.path!;
    // print(docText);
    // getFile(data.replaceAll(RegExp("//"), ''));
    // _isLoading = true;
    // _pickPDFText(widget.path!);
    // final pdfController = PdfController(
    //   document: PdfDocument.('assets/sample.pdf'),
    // );

    // PdfDocument.openData(InternetFile.get('https://github.com/ScerIO/packages.flutter/raw/fd0c92ac83ee355255acb306251b1adfeb2f2fd6/packages/native_pdf_renderer/example/assets/sample.pdf'));
    // pdfController = PdfController(
    //   document:  PdfDocument.openData(InternetFile.get(docText)),
    // initialPage: 1
    // );
    // print(pdfController.pagesCount);
    getData(docText);
    // print(pdfController.page);
    // pdfController.page;
  }
  getData(String data){
    _pdfController = PdfController(
      document:  PdfDocument.openData(InternetFile.get(data)),
      // initialPage: 1
    );
    _pdfController.pagesCount;
    // _pdfController.page;
  }
//   getFile(String data)async {
//   document = await PDFDocument.fromURL(
//       "http://118.70.233.226/file/Lenh_xuat_kho_8861_15C19793_VJS_04.pdf");
//   print(data);
// }
  // _pickPDFText(String url) async {
  //   PDFDoc doc = await PDFDoc.fromURL('${AppConfigs.apiServerChat}/$url');
  //
  //   docText = await doc.text;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pdfController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // return  Center(
    // child: _isLoading
    // ? const Center(child: CircularProgressIndicator())
    //     :
    // child:
    // PDFViewer(
    // document: document!,
    // zoomSteps: 1,));

    // return const WebView(
    //   initialUrl:  "http://118.70.233.226/file/Lenh_xuat_kho_8861_15C19793_VJS_04.pdf",
    // );

    return PdfView(
      controller: _pdfController,
    );

    // return PdfPageNumber(
    //   controller: pdfController,
    //   // When `loadingState != PdfLoadingState.success`  `pagesCount` equals null_
    //   builder: (_, state, loadingState, pagesCount) => Container(
    //     alignment: Alignment.topRight,
    //     child: Text(
    //       '${pagesCount ?? 0}',
    //       style: const TextStyle(fontSize: 22),
    //     ),
    //   ),
    // );
  }
}
class DataUtils {
  static String formatCurrency (String ?currency, num ?amount){
    // if(currency=='VND') {
    //   return NumberFormat.simpleCurrency(locale: "vi_VND",).format(amount);
    //   final number  = new NumberFormat("#,##0", "vi_VND");
    // } else {
    //   final number  = new NumberFormat("#,##0", "vi_VND");
    //   return NumberFormat.simpleCurrency(locale: "en_USD").format(amount);
    // }

    // VNĐ
    final number  = NumberFormat("#,##0", "vi_VND");

    // USD
    // final number  = new NumberFormat("#,##0", "en_US");

    return number.format(amount);
  }

}
class CurrencyInputTFormatter extends TextInputFormatter {
  CurrencyInputTFormatter({this.number,this.maxDigits = 15});
  late int? maxDigits;
  late int? number;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (newValue.selection.baseOffset > maxDigits!) {
      return oldValue;
    }

    final oldValueText = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String newValueText = newValue.text;

    // We manually remove the value we want to remove
    // If oldValueText == newValue.text it means we deleted a non digit number.
    if (oldValueText == newValue.text) {
      newValueText = newValueText.substring(0, newValue.selection.end - 1) +
          newValueText.substring(newValue.selection.end, newValueText.length);
    }
    // print(newValueText);
    double value = double.parse(newValueText.replaceAll(".", ""));
    print(newValueText.replaceAll(".", ""));
    // final formatter = NumberFormat.currency(locale: 'eu', symbol: '€');
    // String newText = formatter.format(value / 100);
    String newText =  DataUtils.formatCurrency("",value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
