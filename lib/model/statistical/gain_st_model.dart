import 'package:food_livraison_app/function/date_parse.dart';

class GainStModel {
  List<int>? montant;
  List<int>? day;
  List<int>? month;
  List<int>? year;
  bool? stat;
  String? monthName;
  int? yearNow;
  GainStModel({this.montant, this.day, this.stat, this.monthName});
  GainStModel.fromJsonListDay(List<Map> data) {
    day = [];
    montant = [];
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
        montant!.add(int.parse(data.elementAt(y)["montant"]));
        y++;
      } else {
        montant!.add(int.parse("0"));
      }
    }
  }
  GainStModel.fromJsonListMonth(List<Map> data) {
    month = [];
    montant = [];
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
        montant!.add(int.parse(data.elementAt(y)["montant"]));
        y++;
      } else {
        montant!.add(int.parse("0"));
      }
    }
  }
  GainStModel.fromJsonListYear(List<Map> data) {
    year = [];
    montant = [];

    List<int> yearExist = [];
    data.forEach((element) {
      yearExist.add(int.parse(element["date"]));
    });
    print(year);
    int y = 0;
    for (var i = 0; i <= 10; i++) {
      year!.add(19 + i + 1);
      if (yearExist.contains(2019 + i + 1)) {
        montant!.add(int.parse(data.elementAt(y)["montant"]));
        y++;
      } else {
        montant!.add(int.parse("0"));
      }
    }
  }
}
