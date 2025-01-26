

import 'package:flutter/material.dart';
import 'package:jeb_ui/all.dart';

class CustomHeader extends StatelessWidget {
  final String userName;

  const CustomHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "طاب مساءك",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextAndIconColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextAndIconColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Card(
            color: AppColors.kContentColor,
            child: IconButton(
              icon: const Icon(Icons.notifications_rounded,
                  color: AppColors.kprimaryColor),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
