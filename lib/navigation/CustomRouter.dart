import 'package:flutter/material.dart';
import '../pages/HomePage.dart';
import '../pages/SubPage.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case RoutePaths.Home:
        return MaterialPageRoute(
            builder: (context) => const HomePage(),
            settings: const RouteSettings(name: RoutePaths.Home));

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.SubPage:
        //Here you can read arguments from the settings to pass to the new page
        return MaterialPageRoute(
          builder: (context) => const SubPage(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong'),
        ),
      ),
    );
  }
}

class RoutePaths {
  static const String SubPage = '/subPage';
  static const String Home = '/home';
}
