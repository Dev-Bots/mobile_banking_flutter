import 'package:mobile_banking/presentation/screens/agent_pages/agent_home.dart';
import 'package:mobile_banking/presentation/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_banking/presentation/screens/saved_accounts.dart';
import 'package:mobile_banking/presentation/widgets/custom_agent_widgets/agent_bottom_nav.dart';
import 'package:mobile_banking/presentation/widgets/custom_client_widgets/client_bottom_nav.dart';
import 'package:flutter/services.dart';

// void main() => runApp(HomePage());

/// This is the main application widget.
class AgentDashboard extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  // MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    AgentHomePage(),
    ProfilePage(),
    // ProfilePage(),
    // ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white); //this change the status bar color to white
    // FlutterStatusbarcolor.setNavigationBarColor(Colors.green); //this sets the navigation bar color to green

    SystemChrome.setEnabledSystemUIOverlays([]);

    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blueAccent,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors
                          .yellow))), // sets the inactive color of the `BottomNavigationBar`
          child: AgentBottomNavigation(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
