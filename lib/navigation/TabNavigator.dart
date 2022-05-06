import 'package:flutter/material.dart';
import '/pages/FirstTabPage.dart';
import '/pages/SecondTabPage.dart';
import '/pages/ThirdTabPage.dart';
import '../pages/HomePage.dart';
import 'CustomRouter.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;
  final RouteObserver<ModalRoute> routeObserver;

  const TabNavigator({Key? key, required this.navigatorKey, required this.item, required this.routeObserver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder();
    return Navigator(
      key: navigatorKey,
      observers: [routeObserver],
      initialRoute: tabNavigatorRoot,
      //Generates the initial route for each tab
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
              settings: const RouteSettings(name: tabNavigatorRoot),
              builder: (context) => routeBuilders[initialRoute]!(context))
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilder() {
    return {tabNavigatorRoot: (context) => _getPage(context, item)};
  }

  _getPage(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.one:
        return const FirstTabPage();
      case BottomNavItem.two:
        return const SecondTabPage();
      case BottomNavItem.three:
        return const ThirdTabPage();
      default:
        return const Scaffold();
    }
  }
}