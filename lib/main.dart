import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:iplinfoapp/pages/Matches.dart';
import 'package:iplinfoapp/pages/pointsTable.dart';
import 'package:iplinfoapp/pages/stats.dart';
import 'package:iplinfoapp/pages/teams.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> pageoptions = [
    MatchesPage(),
    TeamsPage(),
    PointsTablePage(),
    StatsPage(),
  ];

  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageoptions[page],
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          height: 50,
          backgroundColor: Colors.white,
          items: [
            Icon(Icons.home, size: 32, color: Colors.black),
            Icon(Icons.person, size: 32, color: Colors.black),
            Icon(Icons.table_chart, size: 32, color: Colors.black),
            Icon(Icons.trending_up, size: 32, color: Colors.black),
          ]),
    );
  }
}
