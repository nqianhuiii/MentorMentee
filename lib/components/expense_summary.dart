import 'package:flutter/material.dart';
import 'package:flutter_application_1/bar%20graph/bar_graph.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  // calculate max amount in bar graph
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calDailyExpenseSummary()[sunday] ?? 0,
      value.calDailyExpenseSummary()[monday] ?? 0,
      value.calDailyExpenseSummary()[tuesday] ?? 0,
      value.calDailyExpenseSummary()[wednesday] ?? 0,
      value.calDailyExpenseSummary()[thursday] ?? 0,
      value.calDailyExpenseSummary()[friday] ?? 0,
      value.calDailyExpenseSummary()[saturday] ?? 0,
    ];

    // sort from smallest to  largest
    values.sort();

    // get largest amount (at the end of the sorted list)
    // and increase the cap slightly so the graph looks almost full
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  // calculate the week total
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ){
    List<double> values = [
      value.calDailyExpenseSummary()[sunday] ?? 0,
      value.calDailyExpenseSummary()[monday] ?? 0,
      value.calDailyExpenseSummary()[tuesday] ?? 0,
      value.calDailyExpenseSummary()[wednesday] ?? 0,
      value.calDailyExpenseSummary()[thursday] ?? 0,
      value.calDailyExpenseSummary()[friday] ?? 0,
      value.calDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total= 0;
    for(int i= 0; i<values.length; i++){
      total+= values[i];
    }    

    return total.toStringAsFixed(2);  // return string witn 2 decimal place
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // week total
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Week Total:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                Text("RM ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}")
                ],
            ),
          ),

          // bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
              sunAmount: value.calDailyExpenseSummary()[sunday] ??
                  0, // can be null if there is no expenses
              monAmount: value.calDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.calDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
