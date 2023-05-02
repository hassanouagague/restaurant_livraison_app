import 'package:food_livraison_app/function/date_parse.dart';

class LivStModel {
  List<int>? nbr;
  List<int>? day;
  List<int>? month;
  List<int>? year;
  bool? stat;
  String? monthName;
  int? yearNow;
  LivStModel({this.nbr, this.day, this.stat, this.monthName});
  LivStModel.fromJsonListDay(List<Map> data) {
    day = [];
    nbr = [];
    DateTime parsedDate = DateTime.parse(data.elementAt(0)["Date"]);
    monthName = DateParse().monthNumToName(parsedDate.month);
    List dayExist = [];
    data.forEach((element) {
      dayExist.add(DateTime.parse(element["Date"]).day);
    });
    int dayInM = DateParse()
        .daysInMonth(month: parsedDate.month, forYear: parsedDate.year);
    int y = 0;
    for (var i = 0; i < dayInM; i++) {
      day!.add(i + 1);
      if (dayExist.contains(i + 1)) {
        nbr!.add(int.parse(data.elementAt(y)["nbr"]));
        y++;
      } else {
        nbr!.add(int.parse("0"));
      }
    }
  }
  LivStModel.fromJsonListMonth(List<Map> data) {
    month = [];
    nbr = [];
    DateTime parsedDate = DateTime.now();
    yearNow = parsedDate.year;
    List<int> monthExist = [];
    data.forEach((element) {
      monthExist.add(int.parse(element["Date"]));
    });
    int y = 0;
    for (var i = 0; i < 12; i++) {
      month!.add(i + 1);
      if (monthExist.contains(i + 1)) {
        nbr!.add(int.parse(data.elementAt(y)["nbr"]));
        y++;
      } else {
        nbr!.add(int.parse("0"));
      }
    }
  }
  LivStModel.fromJsonListYear(List<Map> data) {
    year = [];
    nbr = [];

    List<int> yearExist = [];
    data.forEach((element) {
      yearExist.add(int.parse(element["Date"]));
    });
   
    int y = 0;
    for (var i = 0; i <= 20; i++) {
      year!.add(2019 + i + 1);
      if (yearExist.contains(2019 + i + 1)) {
        nbr!.add(int.parse(data.elementAt(y)["nbr"]));
        y++;
      } else {
        nbr!.add(int.parse("0"));
      }
    }
  }
}
