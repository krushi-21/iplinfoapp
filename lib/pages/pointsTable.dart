import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:iplinfoapp/variable.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class PointsTablePage extends StatefulWidget {
  @override
  _PointsTablePageState createState() => _PointsTablePageState();
}

class _PointsTablePageState extends State<PointsTablePage> {
  List teams = [];
  List played = [];
  List wins = [];
  List looses = [];
  List points = [];
  bool dataisthere = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettable();
  }

  gettable() async {
    String url = "https://www.iplt20.com/points-table/2020";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    final teamclass = document.getElementsByClassName(
        "standings-table__team-name standings-table__team-name--short js-team");

    for (var i = 0; i < teamclass.length; i++) {
      teams.add(teamclass[i].innerHtml);
    }
    final playedclass =
        document.getElementsByClassName("standings-table__padded");
    for (var i = 0; i < playedclass.length; i++) {
      played.add(playedclass[i].innerHtml);
    }
    /* final wonandlostclass =
        document.getElementsByClassName("standings-table__optional");
    for (var i = 0; i < wonandlostclass.length; i++) {
      for (var j = 0; j < wonandlostclass.length; j = j + 8) {
        if (i == j) {
          wins.add(wonandlostclass[i].innerHtml);

          looses.add(wonandlostclass[i + 1].innerHtml);
        }
      }
    } */

    final wo = document.getElementsByClassName("standings-table__optional");
    for (var i = 6; i < wo.length; i = i + 8) {
      wins.add(wo[i].innerHtml);
      looses.add(wo[i + 1].innerHtml);
    }

    final pointsclass =
        document.getElementsByClassName("standings-table__highlight js-points");
    for (var i = 0; i < pointsclass.length; i++) {
      points.add(pointsclass[i].innerHtml);
    }

    setState(() {
      dataisthere = true;

      print(wins);
      print(looses);
    });
  }

  buildrow(team, pid, won, lost, points, bool iswhite) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          color: iswhite == true ? Colors.white : Colors.grey[200]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            team,
            style: myStyle(17, Colors.black, FontWeight.w500),
          ),
          Text(
            pid,
            style: myStyle(17, Colors.black, FontWeight.w500),
          ),
          Text(
            won,
            style: myStyle(17, Colors.black, FontWeight.w500),
          ),
          Text(
            lost,
            style: myStyle(17, Colors.black, FontWeight.w500),
          ),
          Text(
            points,
            style: myStyle(17, Colors.black, FontWeight.w500),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataisthere == false
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: GradientColors.coolBlues)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Team",
                          style: myStyle(17, Colors.white, FontWeight.w500),
                        ),
                        Text(
                          "Pid",
                          style: myStyle(17, Colors.white, FontWeight.w500),
                        ),
                        Text(
                          "Won",
                          style: myStyle(17, Colors.white, FontWeight.w500),
                        ),
                        Text(
                          "Lost",
                          style: myStyle(17, Colors.white, FontWeight.w500),
                        ),
                        Text(
                          "Pts",
                          style: myStyle(17, Colors.white, FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  buildrow(teams[0], played[1], wins[0], looses[0], points[0],
                      false),
                  buildrow(
                      teams[1], played[2], wins[1], looses[1], points[1], true),
                  buildrow(teams[2], played[3], wins[2], looses[2], points[2],
                      false),
                  buildrow(
                      teams[3], played[4], wins[3], looses[3], points[3], true),
                  buildrow(teams[4], played[5], wins[4], looses[4], points[4],
                      false),
                  buildrow(
                      teams[5], played[6], wins[5], looses[5], points[5], true),
                  buildrow(teams[6], played[7], wins[6], looses[6], points[6],
                      false),
                  buildrow(
                      teams[7], played[8], wins[7], looses[7], points[7], true),
                ],
              ),
            ),
    );
  }
}
/*                buildrow(teams[0], played[1], wins[1], looses[1], points[0],false),
                  buildrow(teams[1], played[2], wins[2], looses[2], points[1], true),
                  buildrow(teams[2], played[3], wins[3], looses[3], points[2],false),
                  buildrow(teams[3], played[4], wins[4], looses[4], points[3], true),
                  buildrow(teams[4], played[5], wins[5], looses[5], points[4],false),
                  buildrow(teams[5], played[6], wins[6], looses[6], points[5], true),
                  buildrow(teams[6], played[7], wins[7], looses[7], points[6],false),
                  buildrow(teams[7], played[8], wins[8], looses[8], points[7], true), */
