class DateParse {
  static const List<String> M = [
    "",
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];
  int daysInMonth({int? month, int? forYear}) {
    DateTime firstOfNextMonth;
    if (month == 12) {
      firstOfNextMonth =
          DateTime(forYear! + 1, 1, 1, 12); //year, month, day, hour
    } else {
      firstOfNextMonth = DateTime(forYear!, month! + 1, 1, 12);
    }
    int numberOfDaysInMonth = firstOfNextMonth.subtract(Duration(days: 1)).day;
    //.subtract(Duration) returns a DateTime, .day gets the integer for the day of that DateTime
    return numberOfDaysInMonth;
  }

  String monthNumToName(int? monthNum) {
    String monthName = M[monthNum!];
    return monthName;
  }
}
