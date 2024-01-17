// ignore_for_file: use_build_context_synchronously

import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_button.dart';
import 'package:attandance_management_system/components/my_textfield.dart';
import 'package:attandance_management_system/services/grade/gradesystem_service.dart';
import 'package:flutter/material.dart';

class GradeSystemPage extends StatefulWidget {
  const GradeSystemPage({super.key});

  @override
  GradeSystemPageState createState() => GradeSystemPageState();
}

class GradeSystemPageState extends State<GradeSystemPage> {
  TextEditingController aGradeController = TextEditingController();
  TextEditingController bGradeController = TextEditingController();
  TextEditingController cGradeController = TextEditingController();
  TextEditingController dGradeController = TextEditingController();
  GradeSystemService service = GradeSystemService();

  @override
  void initState() {
    getGrades();
    super.initState();
  }

  void getGrades() async {
    try {
      final grades = await service.getGradingSystem();
      aGradeController.text = grades[0]['a_grade'].toString();
      bGradeController.text = grades[0]['b_grade'].toString();
      cGradeController.text = grades[0]['c_grade'].toString();
      dGradeController.text = grades[0]['d_grade'].toString();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(title: "Error", content: e.toString());
          });
    }
  }

  void saveGrades() async {
    try {
      await service.saveGradingSystem(aGradeController.text,
          bGradeController.text, cGradeController.text, dGradeController.text);
      showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
                title: "Success", content: "Grade Save Successfully");
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(title: "Error", content: e.toString());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grading System'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Configure Grade System",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                label: "A Grade",
                controller: aGradeController,
                hintText: "A Grade (e.g., 26 days or more)",
                obscureText: false,
                keybordType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              MyTextField(
                label: "B Grade",
                controller: bGradeController,
                hintText: "B Grade (e.g., 20 - 25 days)",
                obscureText: false,
                keybordType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              MyTextField(
                label: "C Grade",
                controller: cGradeController,
                hintText: "C Grade (e.g., 15 - 19 days)",
                obscureText: false,
                keybordType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              MyTextField(
                label: "D Grade",
                controller: dGradeController,
                hintText: "D Grade (e.g., 10 - 14 days)",
                obscureText: false,
                keybordType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: saveGrades,
                text: "Saving Grade System",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
