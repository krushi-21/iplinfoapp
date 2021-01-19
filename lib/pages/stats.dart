import 'package:flutter/material.dart';
import 'package:iplinfoapp/orangecap.dart';
import 'package:iplinfoapp/purplecap.dart';
import 'package:iplinfoapp/variable.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  buildtabs(String title, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 40,
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(
          title,
          style: myStyle(20, Colors.white, FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Leaders",
          style: myStyle(25, Colors.black),
        ),
        bottom: TabBar(controller: tabController, tabs: [
          buildtabs("Orange Cap", Colors.orange),
          buildtabs("Purple Cap", Colors.purple)
        ]),
      ),
      body: TabBarView(
          controller: tabController, children: [OrangeCap(), PurpleCap()]),
    );
  }
}
