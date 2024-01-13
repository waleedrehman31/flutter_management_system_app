import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_datatable.dart';
import 'package:attandance_management_system/services/leave/leave_services.dart';
import 'package:flutter/material.dart';

class LeaveRequestPage extends StatelessWidget {
  LeaveRequestPage({super.key});

  final LeaveService _leaveService = LeaveService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All User Attandance"),
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
      future: _leaveService.getLeaveRequests(),
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
        return MyDataTable(
          cols: const [
            DataColumn(
              label: Text('id'),
            ),
            DataColumn(
              label: Text('Status'),
            ),
            DataColumn(
              label: Text('Action'),
            ),
          ],
          rows: snapshot.data!
              .map(
                (record) => DataRow(
                  cells: [
                    DataCell(Text(record['id'])),
                    DataCell(Text(record['status'])),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          // Implement logic to approve leave request
                        },
                        child: Text('Approve'),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
