import 'package:flutter/material.dart';
import 'package:iplinfoapp/variable.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class ViewTeam extends StatefulWidget {
  final String team;
  final String team_sc;
  final List<Color> color;
  final String url;
  ViewTeam(this.team, this.team_sc, this.color, this.url);
  @override
  _ViewTeamState createState() => _ViewTeamState();
}

class _ViewTeamState extends State<ViewTeam> {
  List iplmatches = [];
  List matchnumbers = [];
  List matchdate = [];
  bool dataisthere = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getteamschedule();
  }

  getteamschedule() async {
    String url = "https://www.iplt20.com/teams/${widget.url}/schedule";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    final nameclass = document.getElementsByClassName("fixture__team-name");

    final matchnumberclass =
        document.getElementsByClassName("fixture__description");
    final dateclass =
        document.getElementsByClassName("match-list__date js-date");

    for (var i = 0; i < nameclass.length; i++) {
      for (var j = 0; j < nameclass.length; j = j + 4) {
        if (i == j) {
          IplMatch iplMatch = IplMatch(
              nameclass[i].innerHtml,
              nameclass[i + 1].innerHtml,
              nameclass[i + 2].innerHtml,
              nameclass[i + 3].innerHtml);
          iplmatches.add(iplMatch);
        } else {}
      }
    }
    for (var i = 0; i < matchnumberclass.length; i++) {
      matchnumbers.add(matchnumberclass[i].innerHtml);
    }

    for (var i = 0; i < matchnumberclass.length; i++) {
      matchdate.add(dateclass[i].innerHtml);
    }
    setState(() {
      dataisthere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: widget.color)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                      height: 200,
                      width: 150,
                      image: AssetImage("images/${widget.team}.png")),
                  Text(
                    widget.team_sc,
                    style: myStyle(45),
                  )
                ],
              ),
            ),
            dataisthere == false
                ? CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: iplmatches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image(
                                        width: 54,
                                        height: 54,
                                        image: AssetImage(
                                            "images/${iplmatches[index].secondteam}.png")),
                                    Text(
                                      "VS",
                                      style: myStyle(20, Colors.grey),
                                    ),
                                    Image(
                                        width: 54,
                                        height: 54,
                                        image: AssetImage(
                                            "images/${iplmatches[index].firstteam}.png"))
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      matchdate[index],
                                      style: myStyle(
                                          14, Colors.black, FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      matchnumbers[index],
                                      style: myStyle(
                                          14, Colors.red, FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}
