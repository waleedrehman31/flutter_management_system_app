import 'package:flutter/material.dart';

class MyDataTable extends StatelessWidget {
  List<DataRow> rows;
  MyDataTable({super.key, required this.rows});

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
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text('Date'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}
