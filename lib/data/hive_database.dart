import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDataBase {
  // reference our box openned
  final _myBox = Hive.box("expense_database");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    /*
      Hive can only store strings and dateTime, but nit custom objexts like ExpenseItem.
      Have to convert ExpenseItem objects into types that can be stored into db
    */

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      // convert each expenseItem into a list of storable types
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // store into db
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {
    /*
      Data stored in Hive is stored as a list of strings + dateTime.
      Have to convert the saved date into ExpenseItem db
    */
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? []; // could be no item saved
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      //collect individual saved data
      String name = savedExpenses[i][0]; // i= particular list, 0/1/2= value in the list
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      // add expense to overall list of expenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
