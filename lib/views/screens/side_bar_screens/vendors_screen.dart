import 'dart:core';

import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({super.key});
  static const String routeName = '/manageVendor';

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
              'Manage Vendor',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('LOGO NAME', 1),
              _rowHeader('BUSINESS NAME', 3),
              _rowHeader('CITY', 2),
              _rowHeader('STATE', 1),
              _rowHeader('ACTION ', 1),
              _rowHeader('VIEW MORE ', 1),
            ],
          )
        ],
      ),
    );
  }
}
