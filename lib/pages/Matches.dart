import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iplinfoapp/variable.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  bool dataisthere = false;
  List iplmatches = [];
  List matchnumbers = [];
  List matchvenues = [];

  @override
  void initState() {
    super.initState();
    getupcomingmatches();
  }

  getupcomingmatches() async {
    String url = "https://www.iplt20.com/matches/schedule/men";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    final nameclass = document.getElementsByClassName("fixture__team-name");

    final matchnumberclass =
        document.getElementsByClassName("fixture__description");
    final venueclass = document.getElementsByClassName("fixture__info");

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
      if (venueclass[i].getElementsByTagName('span')[0].innerHtml != "Live") {
        matchvenues.add(venueclass[i]
            .getElementsByTagName("span")[0]
            .innerHtml
            .substring(49)
            .trim());
      } else {
        matchvenues.add("Live Now");
      }
    }
    setState(() {
      dataisthere = true;
    });
  }

  getnextmatch() async {
    List infos = [];
    String url = "https://www.iplt20.com/matches/schedule/men";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    final nameclass = document.getElementsByClassName("fixture__team-name");

    final matchnumberclass =
        document.getElementsByClassName("fixture__description");
    final venueclass = document.getElementsByClassName("fixture__info");
    print(venueclass[0]
        .getElementsByTagName("span")[0]
        .innerHtml
        .substring(49)
        .trim());
    infos.add(nameclass[0].innerHtml);
    infos.add(nameclass[1].innerHtml);
    infos.add(nameclass[2].innerHtml);
    infos.add(nameclass[3].innerHtml);
    infos.add(matchnumberclass[0].innerHtml);
    if (venueclass[0].getElementsByTagName('span')[0].innerHtml != "Live") {
      infos.add(venueclass[0]
          .getElementsByTagName("span")[0]
          .innerHtml
          .substring(49)
          .trim());
    } else {
      infos.add("Live Now");
    }
    return infos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(color: Colors.blue),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "IPL Center",
                      textAlign: TextAlign.center,
                      style: myStyle(25, Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Next Match",
                      style: myStyle(20, Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(color: Colors.white),
                    child: FutureBuilder(
                      future: getnextmatch(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image(
                                        width: 64,
                                        height: 64,
                                        image: AssetImage(
                                            "images/${snapshot.data[0]}.png")),
                                    Text(
                                      "Vs",
                                      style: myStyle(20, Colors.black),
                                    ),
                                    Image(
                                        width: 64,
                                        height: 64,
                                        image: AssetImage(
                                            "images/${snapshot.data[2]}.png")),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data[1],
                                      style: myStyle(
                                          25,
                                          getTeamColor(
                                            snapshot.data[1],
                                          )),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      snapshot.data[3],
                                      style: myStyle(
                                          25,
                                          getTeamColor(
                                            snapshot.data[3],
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  snapshot.data[4],
                                  style:
                                      myStyle(20, Colors.red, FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    snapshot.data[5],
                                    textAlign: TextAlign.center,
                                    style: myStyle(
                                        13, Colors.black, FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Future Matches",
                      style: myStyle(20, Colors.blue, FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  dataisthere == false
                      ? CircularProgressIndicator()
                      : CarouselSlider.builder(
                          itemCount: iplmatches.length,
                          options: CarouselOptions(
                              viewportFraction: 0.8,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayCurve: Curves.easeIn,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800)),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 350,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image(
                                              width: 64,
                                              height: 64,
                                              image: AssetImage(
                                                  "images/${iplmatches[index].firstteam}.png")),
                                          Text(
                                            "Vs",
                                            style: myStyle(20, Colors.black),
                                          ),
                                          Image(
                                              width: 64,
                                              height: 64,
                                              image: AssetImage(
                                                  "images/${iplmatches[index].secondteam}.png")),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "${iplmatches[index].firstteam_sc}",
                                            style: myStyle(
                                                25,
                                                getTeamColor(
                                                  "${iplmatches[index].firstteam_sc}",
                                                )),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "${iplmatches[index].secondteam_sc}",
                                            style: myStyle(
                                                25,
                                                getTeamColor(
                                                    "${iplmatches[index].secondteam_sc}")),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        matchnumbers[index].toString(),
                                        style: myStyle(
                                            20, Colors.red, FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          matchvenues[index].toString(),
                                          textAlign: TextAlign.center,
                                          style: myStyle(13, Colors.black,
                                              FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                ],
              ),
            )
          ],
        ),
        physics: ScrollPhysics(),
      ),
    );
  }
}
