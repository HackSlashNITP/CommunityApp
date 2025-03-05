import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LearningCard extends StatelessWidget {
  const LearningCard(
      {super.key,
      required this.imagePath,
      required this.cardName,
      required this.onTap});

  final String imagePath;
  final String cardName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width = Get.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xFFE3F5FF),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: width * 0.2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                cardName.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.05),
              )
            ],
          )),
    );
  }
}
