import 'package:food_livraison_app/function/date_parse.dart';

class PenaliteStModel {
  
  List? somme;
  List? penalite;
  List<int>? day;
  List<int>? month;
  List<int>? year;
  bool? stat;
  String? monthName;
  int? yearNow;
  PenaliteStModel({this.somme,this.penalite, this.day, this.stat, this.monthName});
  PenaliteStModel.fromJsonListDay(List<Map> data) {
    day = [];
    somme = [];
    penalite = [];
    DateTime parsedDate = DateTime.parse(data.elementAt(0)["date"]);
    monthName = DateParse().monthNumToName(parsedDate.month);
    List dayExist = [];
    data.forEach((element) {
      dayExist.add(DateTime.parse(element["date"]).day);
    });
    int dayInM = DateParse()
        .daysInMonth(month: parsedDate.month, forYear: parsedDate.year);
    int y = 0;
    for (var i = 0; i < dayInM; i++) {
      day!.add(i + 1);
      if (dayExist.contains(i + 1)) {
        somme !.add(int.parse(data.elementAt(y)["somme"]));
        penalite!.add(int.parse(data.elementAt(y)["penalite"]));
        y++;
      } else {
        somme!.add(int.parse("0"));
        penalite!.add(int.parse("0"));
      }
    }
  }
  PenaliteStModel.fromJsonListMonth(List<Map> data) {
    month = [];
    somme = [];
    penalite = [];
    DateTime parsedDate = DateTime.now();
    yearNow = parsedDate.year;
    List<int> monthExist = [];
    data.forEach((element) {
      monthExist.add(int.parse(element["date"]));
    });
    int y = 0;
    for (var i = 0; i < 12; i++) {
      month!.add(i + 1);
      if (monthExist.contains(i + 1)) {
        somme !.add(int.parse(data.elementAt(y)["somme"]));
        penalite!.add(int.parse(data.elementAt(y)["penalite"]));
        y++;
      } else {
        somme!.add(int.parse("0"));
        penalite!.add(int.parse("0"));
      }
    }
  }
  PenaliteStModel.fromJsonListYear(List<Map> data) {
    year = [];
    somme = [];
    penalite = [];

    List<int> yearExist = [];
    data.forEach((element) {
      yearExist.add(int.parse(element["date"]));
    });
    print(year);
    int y = 0;
    for (var i = 0; i <= 10; i++) {
      year!.add(19 + i + 1);
      if (yearExist.contains(2019 + i + 1)) {
        somme !.add(int.parse(data.elementAt(y)["somme"]));
        penalite!.add(int.parse(data.elementAt(y)["penalite"]));
        y++;
      } else {
        somme!.add(int.parse("0"));
        penalite!.add(int.parse("0"));
      }
    }
  }
}
