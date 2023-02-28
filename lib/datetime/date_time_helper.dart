// convert DateTime object to a string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // year in yyyy format
  String year = dateTime.year.toString();

  // month in mm format
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '${month}0';
  }

  // day in dd format
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day += '0';
  }

  return (year + month + day);
}

/*
  dateTime.now() -> 2023/2/11/hour/minutes/seconds...
                 -> 20230211
*/