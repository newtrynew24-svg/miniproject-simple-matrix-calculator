import 'package:flutter/material.dart';
import 'package:simple_matrix_calculator/core/constants/app_colors.dart';

class IncreaseDecreaseButton extends StatelessWidget {
  String sign;

  IncreaseDecreaseButton(this.sign, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: AppColors.increaseDecreaseButton,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.buttonBorder, width: 1),
        ),
        child: Center(
          child: Text(
            sign,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.buttonText,
              height: 1.0,
            ),
            textHeightBehavior: TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
          ),
        ),
      );
  }
}
