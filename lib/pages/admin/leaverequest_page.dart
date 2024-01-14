import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_card.dart';
import 'package:attandance_management_system/services/leave/leave_services.dart';
import 'package:flutter/material.dart';

class LeaveRequestPage extends StatefulWidget {
  const LeaveRequestPage({super.key});

  @override
  State<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final LeaveService _leaveService = LeaveService();

  void acceptLeaveRequest(String userUid, leaveUid) {
    try {
      _leaveService.acceptLeaveRequest(userUid, leaveUid);
      showDialog(
          context: context,
          builder: (context) => const MyAlertDialog(
              title: "Error", content: "Leave Approved Successfully"));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) =>
              MyAlertDialog(title: "Error", content: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Requests"),
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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _buildProgessList(),
        ),
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
        if (snapshot.data!.isEmpty) {
          return const Text("No Leave Request Pending.");
        }
        return Column(
          children: snapshot.data!
              .map(
                (record) => MyCard(
                  name: record['name'],
                  date: record['date'],
                  onPressed: () =>
                      acceptLeaveRequest(record['userUid'], record['leaveUid']),
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
