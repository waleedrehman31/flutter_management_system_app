import 'package:attandance_management_system/components/my_drawer.dart';
import 'package:attandance_management_system/components/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
                  onTap: () {},
                  icon: Icons.assignment_turned_in_sharp,
                  text: "Mark Attandance",
                  date: currentDate,
                ),
                const SizedBox(
                  width: 15,
                ),
                SquareTile(
                  onTap: () {},
                  icon: Icons.add,
                  text: "Leave Request",
                  date: currentDate,
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
                  onTap: () {},
                  icon: Icons.remove_red_eye_outlined,
                  text: "View Progress",
                  date: "",
                ),
                const SizedBox(
                  width: 15,
                ),
                SquareTile(
                  onTap: () {},
                  icon: Icons.person_2_outlined,
                  text: "P R O F I L E",
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
