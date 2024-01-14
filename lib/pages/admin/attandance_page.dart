import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_datatable.dart';
import 'package:attandance_management_system/services/attandance/attendance_service.dart';
import 'package:flutter/material.dart';

class AttandancePage extends StatelessWidget {
  AttandancePage({super.key});

  final Attandance _attandanceService = Attandance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progess"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildProgessList(),
      ),
    );
  }

  Widget _buildProgessList() {
    return FutureBuilder(
      future: _attandanceService.getAllAttandance(),
      builder: ((context, snapshot) {
        //error
        if (snapshot.hasError) {
          return MyAlertDialog(
            title: "Error",
            content: snapshot.error.toString(),
          );
        }

        // loading ...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading ...");
        }

        // list
        return MyDataTable(
          cols: const [
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('Date'),
            ),
            DataColumn(
              label: Text('Status'),
            ),
          ],
          rows: snapshot.data!
              .map(
                (record) => DataRow(
                  cells: [
                    DataCell(Text(record['name'])),
                    DataCell(Text(record['date'])),
                    DataCell(Text(record['status'].toString())),
                  ],
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
