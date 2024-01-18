// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_button.dart';
import 'package:attandance_management_system/services/attandance/attendance_service.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  DateTime? fromDate;
  DateTime? toDate;
  late var users = [];
  String dropdownValue = "Select User";
  // List<Map<String, dynamic>>? reportData;
  var userReport;
  final Attandance _attandanceService = Attandance();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void getUsers() async {
    final response = await _attandanceService.getAllUsers();
    setState(() {
      users = response;
    });
  }

  void generateReport() async {
    try {
      if (!(fromDate != null && toDate != null)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please select both From Date and To Date.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        userReport = await _attandanceService.generateUserAttendanceReport(
            fromDate, toDate, dropdownValue);
        print(userReport);
        setState(() {
          userReport = userReport;
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog(title: "Error", content: e.toString());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Attendance Report'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              DropdownMenu(
                width: 220.0,
                initialSelection: "Select User",
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    users.map<DropdownMenuEntry<String>>((value) {
                  return DropdownMenuEntry<String>(
                      value: value['userUid'], label: value['name']);
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                    onTap: () async {
                      DateTime? selectedDate =
                          await _selectDate('From Date', fromDate);
                      if (selectedDate != null) {
                        setState(() {
                          fromDate = selectedDate;
                        });
                      }
                    },
                    text: "From Date",
                  ),
                  MyButton(
                    onTap: () async {
                      DateTime? selectedDate =
                          await _selectDate('To Date', toDate);
                      if (selectedDate != null) {
                        setState(() {
                          toDate = selectedDate;
                        });
                      }
                    },
                    text: "To Date",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyButton(onTap: generateReport, text: "Generate Report"),
              const SizedBox(height: 20),
              (userReport != null)
                  ? SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'User Attandance Grade: ',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  userReport[0]['grade'],
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: userReport.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MyListCard(
                                  userReport[index]['name'].toString(),
                                  userReport[index]['date'].toString(),
                                  userReport[index]['status'].toString());
                            },
                          ),
                        ],
                      ),
                    )
                  : const Text("Generate The Report First.")
            ],
          ),
        ),
      ),
    );
  }

  Widget MyListCard(name, date, status) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Text("Name:"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text("Date:"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text("Status:"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        status,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<DateTime?> _selectDate(String title, DateTime? initialDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    return selectedDate;
  }
}
