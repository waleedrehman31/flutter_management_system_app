// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyDataTable extends StatelessWidget {
  List<DataRow> rows;
  List<DataColumn> cols;
  MyDataTable({super.key, required this.rows, required this.cols});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: cols,
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }
}
