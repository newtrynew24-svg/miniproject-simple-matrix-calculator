import 'package:flutter/material.dart';
import 'package:simple_matrix_calculator/core/constants/app_colors.dart';

class BlockMatrix extends StatelessWidget {
  final TextEditingController controller;

  const BlockMatrix({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.borderBlockMatrix, width: 2),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: '0',
          hintStyle: TextStyle(
            color: Colors.grey
          )
        ),
      ),
    );
  }
}
