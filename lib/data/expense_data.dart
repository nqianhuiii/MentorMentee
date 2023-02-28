import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/hive_database.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';
import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpensesList() {
    return overallExpenseList;
  }

  // prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    // if there exist data, get it
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners(); // notify clients about objects may have changed
    db.saveData(overallExpenseList);
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
   
    notifyListeners(); // notify clients about objects may have changed
    db.saveData(overallExpenseList);
  }

  // get weekday (mon, tues,...) from a dateTime object (dateTime return int)
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date of the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startofWeek;

    // get today's date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startofWeek = today.subtract(Duration(days: i));
      }
    }

    return startofWeek!; // '!' tells the compiler the variable is not null
  }

  // convert overall list of expenses (food: 10, drink: 5) into a daily expense summary (total: 15)
  Map<String, double> calDailyExpenseSummary() {
    // Map: key/ value pair
    Map<String, double> dailyExpensseSummary = {
      // date (yyyymmdd) : amountTotalForDat
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount =
          double.parse(expense.amount); // convert from string to double

      // to check whether a particular date is already existed
      if (dailyExpensseSummary.containsKey(date)) {
        // contain key-date ?
        double currentAmount = dailyExpensseSummary[date]!;
        currentAmount += amount;
        dailyExpensseSummary[date] = currentAmount;
      } else {
        dailyExpensseSummary.addAll({date: amount});
      }
    }

    return dailyExpensseSummary;
  }
}
