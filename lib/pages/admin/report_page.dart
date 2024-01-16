import 'package:attandance_management_system/components/my_button.dart';
import 'package:attandance_management_system/services/attandance/attendance_service.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  DateTime? fromDate;
  DateTime? toDate;
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  void generateReport() async {
    Attandance attandance = Attandance();
    if (fromDate != null && toDate != null) {
      await attandance.generateUserAttendanceReport(fromDate, toDate);
    } else {
      // Show an error message or alert if dates are not selected
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
    }
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Attendance Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            DropdownMenu(
              initialSelection: list.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries:
                  list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
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
