import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ScalarSection extends StatelessWidget {

  final TextEditingController controller;

  const ScalarSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Number:',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.borderBlockMatrix,
                  width: 2,
                ),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                controller: controller,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
