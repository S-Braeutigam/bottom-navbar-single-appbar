import '../navigation/TabNavigator.dart';
import 'FirstTabPage.dart';
import 'SecondTabPage.dart';
import 'package:flutter/material.dart';
import 'ThirdTabPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with RouteAware {
  int _currentIndex = 0;
  BottomNavItem _currentItem = BottomNavItem.one;

  final Map<BottomNavItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    BottomNavItem.one: GlobalKey<NavigatorState>(),
    BottomNavItem.two: GlobalKey<NavigatorState>(),
    BottomNavItem.three: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, RouteObserver<ModalRoute>> _routeObservers = {
    BottomNavItem.one: RouteObserver<ModalRoute>(),
    BottomNavItem.two: RouteObserver<ModalRoute>(),
    BottomNavItem.three: RouteObserver<ModalRoute>(),
  };

  final List<Widget> _tabs = const [
    FirstTabPage(),
    SecondTabPage(),
    ThirdTabPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading:
              (_navigatorKeys[_currentItem]?.currentState?.canPop() ?? false)
                  ? const BackButton()
                  : null,
        ),
        endDrawer: const Drawer(),
        body: WillPopScope(
          onWillPop: () async {
            _navigatorKeys[_navigatorKeys.keys.elementAt(_currentIndex)]
                ?.currentState
                ?.popUntil((route) => route.isFirst);
            return false;
          },
          child: IndexedStack(
            index: _currentIndex,
            children: _tabs.map((e) => _wrapPageInTabNavigator(e)).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (_currentIndex == index) {
              BottomNavItem currentSelectedItem = BottomNavItem.values[index];
              _navigatorKeys[currentSelectedItem]
                  ?.currentState
                  ?.popUntil((route) => route.isFirst);
            }
            setState(() {
              _currentIndex = index;
              _currentItem = _navigatorKeys.keys.elementAt(_currentIndex);
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "First"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Second"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library), label: "Third"),
          ],
        ));
  }

  Widget _wrapPageInTabNavigator(widget) {
    var index = _tabs.indexOf(widget);
    var item = _navigatorKeys.keys.elementAt(index);
    var observer = _routeObservers[item]!;
    return TabNavigator(
      navigatorKey: _navigatorKeys[item]!,
      item: item,
      routeObserver: observer,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for(BottomNavItem item in _navigatorKeys.keys) {
      RouteObserver observer = _routeObservers[item]!;
      //TODO: This fails because the current state of the NavigatorState does not exist at this point.
      NavigatorState navState = _navigatorKeys[item]!.currentState!;
      observer.subscribe(this, ModalRoute.of(navState.context)!);
    }
  }

  @override
  void didPush() {
    super.didPush();
    print('New route has been pushed');
    //TODO: update the state of HomePage to trigger a rebuild and update the evaluation for displaying the back button in the AppBar
  }

  @override
  void didPop() {
    super.didPop();
    print('Route has been popped');
  }
}

enum BottomNavItem {
  one,
  two,
  three,
}
