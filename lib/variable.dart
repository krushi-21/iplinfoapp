import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double size, [Color color, FontWeight fw = FontWeight.w700]) {
  return GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: fw);
}

class IplMatch {
  final String firstteam;
  final String firstteam_sc;
  final String secondteam;
  final String secondteam_sc;
  IplMatch(
      this.firstteam, this.firstteam_sc, this.secondteam, this.secondteam_sc);
}

class IplTeam {
  final String teamname;
  final String teamname_sc;
  final List<Color> colors;
  final String url;
  IplTeam(this.teamname, this.teamname_sc, this.colors, this.url);
}

getTeamColor(String team) {
  if (team == "DC") {
    return Colors.lightBlue;
  } else if (team == "RR") {
    return Colors.pink;
  } else if (team == "RCB") {
    return Colors.orange;
  } else if (team == "KKR") {
    return Colors.purple;
  } else if (team == "MI") {
    return Colors.indigo;
  } else if (team == "CSK") {
    return Colors.amber;
  } else if (team == "KP") {
    return Colors.pink;
  } else {
    return Colors.amber;
  }
}
