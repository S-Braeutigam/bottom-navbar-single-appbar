import 'package:bottom_navbar_single_appbar/navigation/CustomRouter.dart';
import 'package:flutter/material.dart';

class FirstTabPage extends StatelessWidget {
  const FirstTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('First Page'),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RoutePaths.SubPage);
            },
            child: const Text('Go to sub page.'),
            color: Colors.blue,
          )
        ],
      )),
      color: Colors.amberAccent,
    );
  }
}
