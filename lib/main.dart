import 'package:flutter/material.dart';
import 'navigation/CustomRouter.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamedUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutePaths.Home,
      onGenerateRoute: CustomRouter.onGenerateRoute,
    );
  }
}
