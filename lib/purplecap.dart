import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:iplinfoapp/variable.dart';

class PurpleCap extends StatefulWidget {
  @override
  _PurpleCapState createState() => _PurpleCapState();
}

class _PurpleCapState extends State<PurpleCap> {
  List runs = [];
  List playername = [];
  bool dataisthere = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getorangecap();
  }

  getorangecap() async {
    String url = "https://www.iplt20.com/stats/2020/most-wickets";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    final playernameclass =
        document.getElementsByClassName("top-players__last-name");
    for (var i = 0; i < playernameclass.length; i++) {
      playername.add(playernameclass[i].innerHtml);
    }
    final runclass =
        document.getElementsByClassName("top-players__w  is-active");
    for (var i = 0; i < runclass.length; i++) {
      runs.add(runclass[i].innerHtml);
    }
    setState(() {
      dataisthere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataisthere == false
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(itemBuilder: (BuildContext contaxt, int index) {
              return Card(
                child: ListTile(
                  title: Text(
                    playername[index],
                    style: myStyle(25, Colors.orange),
                  ),
                  trailing: Text(
                    runs[index],
                    style: myStyle(20, Colors.black, FontWeight.bold),
                  ),
                ),
              );
            }),
    );
  }
}
