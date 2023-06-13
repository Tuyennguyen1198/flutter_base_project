import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateBubblesChat extends StatefulWidget {
  const CreateBubblesChat({Key? key}) : super(key: key);

  @override
  State<CreateBubblesChat> createState() => _CreateBubblesChatState();
}

class _CreateBubblesChatState extends State<CreateBubblesChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bubbles chat"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
