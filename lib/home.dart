import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/expense_summary.dart';
import 'package:flutter_application_1/components/expense_tile.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/models/expense_item.dart';
import 'package:provider/provider.dart';
// import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseRinggitController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(hintText: "Expense name"),
            ),

            Row(
              children: [
                // ringgit
                Expanded(
                  child: TextField(
                    controller: newExpenseRinggitController,
                    keyboardType: TextInputType.number, // limit input to numbers only (number keypad)
                    decoration: const InputDecoration(hintText: "Ringgit"),
                  ),
                ),

                // cents
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Cents"),
                  ),
                ),
              ],
            ),
            // expense amount
          ],
        ),
        actions: [
          // save button
          MaterialButton(onPressed: save, child: const Text('Save')),

          // cancel button
          MaterialButton(onPressed: cancel, child: const Text('cancel')),
        ],
      ),
    );
  }

  // save
  void save() {
    // put ringgits and cents together into amount
    String amoount =
        '${newExpenseRinggitController.text}.${newExpenseCentsController.text}';
    // create expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amoount,
      dateTime: DateTime.now(),
    );

    // add the new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear the controllers so that there is no previous value left
  void clear() {
    newExpenseNameController.clear();
    newExpenseRinggitController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          drawer: const NavDrawer(),
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              // weekly summary
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),

              const SizedBox(height: 20),

              // expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpensesList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpensesList()[index].name,
                  amount: value.getAllExpensesList()[index].amount,
                  dateTime: value.getAllExpensesList()[index].dateTime,
                ),
              ),
            ],
          )),
    );
  }
}
