import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMoth = recentTransaction[i].date.day == weekDay.month;
        bool sameYear = recentTransaction[i].date.day == weekDay.year;

        if (sameDay && sameMoth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get _WeekTotalValue {
    return groupTransactions.fold(
        0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    // groupTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: double.parse(tr['value'].toString()),
                  percentage: 0.3),
            ); //(tr['value'] as double) / _WeekTotalValue);
          }).toList(),
        ),
      ),
    );
  }
}
