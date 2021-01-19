import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:iplinfoapp/variable.dart';
import 'package:iplinfoapp/viewteam.dart';

class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  List<IplTeam> teams = [
    IplTeam("Delhi Capitals", "DC", GradientColors.coolBlues, "delhi-capitals"),
    IplTeam("Chennai Super Kings", "CSK", GradientColors.yellow,
        "chennai-super-kings"),
    IplTeam(
        "Kings XI Punjab", "KXIP", GradientColors.radish, "kings-xi-punjab"),
    IplTeam("Kolkata Knight Riders", "KKR", GradientColors.purple,
        "kolkata-knight-riders"),
    IplTeam("Mumbai Indians", "MI", GradientColors.indigo, "mumbai-indians"),
    IplTeam(
        "Rajasthan Royals", "RR", GradientColors.piggyPink, "rajasthan-royals"),
    IplTeam("Royal Challengers Bangalore", "RCB", GradientColors.red,
        "royal-challengers-bangalore"),
    IplTeam("Sunrisers Hyderabad", "SRH", GradientColors.juicyOrange,
        "sunrisers-hyderabad"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: teams.map((e) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewTeam(e.teamname, e.teamname_sc, e.colors, e.url)),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: e.colors),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        height: 100,
                        width: 100,
                        image: AssetImage("images/${e.teamname}.png")),
                    Text(
                      e.teamname_sc,
                      style: myStyle(25, Colors.white, FontWeight.w600),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
