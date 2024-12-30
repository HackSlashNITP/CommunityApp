import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LearningCard extends StatelessWidget {
  const LearningCard({
    super.key,
    required this.imagePath,
    required this.cardName,
    required this.onTap});

  final String imagePath;
  final String cardName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 4,
          color: const Color(0xFFE3E3E3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath,
                height: width * 0.2,),
              const SizedBox(height: 10,),
              Text(cardName.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.05),)
            ],
          )
      ),
    );
  }
}
