import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../sizeBox/size_box.dart';
import '../uiHelper/ui_helper.dart';

class TextFromFeild extends StatefulWidget {
  const TextFromFeild({Key? key}) : super(key: key);

  @override
  State<TextFromFeild> createState() => _TextFromFeildState();
}

class _TextFromFeildState extends State<TextFromFeild> {
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("1"),
      ),
      body: Column(
        children: [
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
                  onSaved: (value) {
                    // _amountController.text = value;
                    // amountNumber = int.parse(value!.replaceAll(".", ""));
                    setState(() {
                    });
                    // print(amountNumber);
                  },
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
    );
  }
}
