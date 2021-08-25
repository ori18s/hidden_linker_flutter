import 'package:flutter/material.dart';
// import 'package:flutter_app/pages/HomeTab.dart';
import 'package:hidden_linker_flutter/widget/home.dart';
// import 'package:flutter_app/widget/Screen/BusinessTab.dart';
// import 'package:flutter_app/widget/Screen/SchoolTab.dart';
// import 'package:flutter_app/widget/Screen/AlarmTab.dart';
// import 'package:flutter_app/widget/SideDrawer.dart';


/// This Widget is the main application widget.
class BottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: BottomStatefulWidget(),
    );
  }
}

class BottomStatefulWidget extends StatefulWidget {
  BottomStatefulWidget({Key key}) : super(key: key);

  @override
  _BottomStatefulWidgetState createState() => _BottomStatefulWidgetState();
}

class _BottomStatefulWidgetState extends State<BottomStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    // BusinessTab(),
    // SchoolTab(),
    // AlarmTab()
  ];

  static const List<Widget> _appBars = <Widget>[
    Icon(Icons.home),
    Icon(Icons.business),
    Icon(Icons.school),
    Icon(Icons.alarm)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBars.elementAt(_selectedIndex),
      ),
      // drawer: SideDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.business),
          //   title: Text('Business'),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   title: Text('School'),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.alarm),
          //   title: Text('Alarm'),
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type : BottomNavigationBarType.fixed
      ),
    );
  }
}