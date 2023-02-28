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

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tueday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          sunAmount: value.calDailyExpenseSummary()[sunday] ?? 0,   // can be null if there is no expenses
          monAmount: value.calDailyExpenseSummary()[monday] ?? 0,
          tueAmount: value.calDailyExpenseSummary()[tueday] ?? 0,
          wedAmount: value.calDailyExpenseSummary()[wednesday] ?? 0,
          thurAmount: value.calDailyExpenseSummary()[thursday] ?? 0,
          friAmount: value.calDailyExpenseSummary()[friday] ?? 0,
          satAmount: value.calDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
