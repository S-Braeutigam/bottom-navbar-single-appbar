import 'package:flutter/material.dart';

class SecondTabPage extends StatelessWidget {
  const SecondTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text('Second Screen'),), color: Colors.blueAccent,),
    );
  }
}