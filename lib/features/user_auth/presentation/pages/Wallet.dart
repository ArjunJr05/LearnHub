// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(WalletPage());

class Transaction {
  final String date;
  final String description;
  final String amount;

  Transaction(
      {required this.date, required this.description, required this.amount});
}

class WalletPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(date: '7Kg', description: '1 Unit', amount: 'Rs.4'),
    Transaction(date: '10Kg', description: '0.5 Units', amount: 'Rs.2'),
    Transaction(date: '9Kg', description: '1.7 Units', amount: 'Rs.5'),
    Transaction(date: '6Kg', description: '0.2 Units', amount: 'Rs.1.5'),
    Transaction(date: '8.8Kg', description: '0.5 Units', amount: 'Rs.2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#ffebe3'),
        appBar: AppBar(
          backgroundColor: HexColor('#ea6c69'),
          title: Text(
            '\t\t       EmpowerWaste',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(children: [
          Text(
            '\nJan to Feb',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                _buildTableRow(['Weight', 'Energy obtained', 'Amount']),
                for (Transaction transaction in transactions)
                  _buildTableRow([
                    transaction.date,
                    transaction.description,
                    transaction.amount,
                  ]),
              ],
            ),
          ),
        ]));
  }

  TableRow _buildTableRow(List<String> values) {
    return TableRow(
      children: values.map((value) => _buildTableCell(value)).toList(),
    );
  }

  Widget _buildTableCell(String value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        textAlign: TextAlign.center,
      ),
    );
  }
}
