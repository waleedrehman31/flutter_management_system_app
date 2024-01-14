// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard(
      {super.key,
      required this.name,
      required this.date,
      required this.onPressed});
  final String name;
  final String date;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.check, size: 18),
                label: const Text(
                  "Approve",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }
}
