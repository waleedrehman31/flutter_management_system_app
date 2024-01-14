import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_datatable.dart';
import 'package:attandance_management_system/services/attandance/attendance_service.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  ProgressPage({super.key});

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
    return StreamBuilder(
      stream: _attandanceService.getUserAttandance(),
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
        var attendanceData = snapshot.data!.docs;
        // list
        return MyDataTable(
          cols: const [
            DataColumn(
              label: Text('Date'),
            ),
            DataColumn(
              label: Text('Status'),
            ),
          ],
          rows: attendanceData
              .map(
                (record) => DataRow(
                  cells: [
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
