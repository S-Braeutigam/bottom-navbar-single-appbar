import 'package:flutter/material.dart';

class ThirdTabPage extends StatelessWidget {
  const ThirdTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text('Third Screen'),), color: Colors.lightGreen,),
    );
  }
}