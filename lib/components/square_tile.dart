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
        height: 160,
        width: 162,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Center(
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
              Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(date),
            ],
          ),
        ),
        // child: Image.asset(
        //   imagePath,
        //   height: 40,
        // ),
      ),
    );
  }
}
