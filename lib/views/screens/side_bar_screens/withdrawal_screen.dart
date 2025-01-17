import 'package:flutter/material.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});
  static const String routeName = '/WithdrawalScreen';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.blue.shade900,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Withdrawal',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('NAME', 1),
              _rowHeader('AMOUNT', 3),
              _rowHeader('BANK NAME', 2),
              _rowHeader('BANK ACCOUNT', 2),
              _rowHeader('EMAIL ', 1),
              _rowHeader('PHONE ', 1),
            ],
          )
        ],
      ),
    );
  }
}
