// ignore_for_file: use_build_context_synchronously
import 'package:attandance_management_system/components/my_drawer.dart';
import 'package:attandance_management_system/components/square_tile.dart';
import 'package:attandance_management_system/pages/admin/attandance_page.dart';
import 'package:attandance_management_system/pages/admin/grade_page.dart';
import 'package:attandance_management_system/pages/admin/leaverequest_page.dart';
import 'package:attandance_management_system/pages/admin/report_page.dart';
import 'package:attandance_management_system/pages/profile_page.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home Page"),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttandancePage()),
                    );
                  },
                  icon: Icons.assignment_turned_in_sharp,
                  text: "View Attandance",
                  date: "",
                ),
                const SizedBox(
                  width: 15,
                ),
                SquareTile(
                  // onTap: () {
                  //   LeaveService a = LeaveService();
                  //   a.getLeaveRequests();
                  // },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeaveRequestPage(),
                      ),
                    );
                  },
                  icon: Icons.add,
                  text: "Leave Requests",
                  date: "",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                  // onTap: () {},
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GradeSystemPage(),
                      ),
                    );
                  },
                  icon: Icons.settings_applications_rounded,
                  text: "Grade Setting",
                  date: "",
                ),
                const SizedBox(
                  width: 15,
                ),
                SquareTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportPage(),
                      ),
                    );
                  },
                  icon: Icons.receipt_long,
                  text: "Grade Report",
                  date: "",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  icon: Icons.person_2_outlined,
                  text: "Profile",
                  date: "",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
