import 'package:flutter/cupertino.dart';

class SizeBoxHelper{
  static   SizedBox sizedBoxWidth(String txt){
    return SizedBox(
      width: 120.0,
      child: Text(txt),
    );
  }
}