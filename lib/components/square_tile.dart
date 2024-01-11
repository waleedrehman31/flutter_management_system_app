import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  // final String imagePath;
  final String text;
  final IconData icon;
  final Function()? onTap;
  final String date;
  const SquareTile(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(text),
            Text(date),
          ],
        ),
        // child: Image.asset(
        //   imagePath,
        //   height: 40,
        // ),
      ),
    );
  }
}
