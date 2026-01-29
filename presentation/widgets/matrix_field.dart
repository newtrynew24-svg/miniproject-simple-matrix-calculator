import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../logic/calculator_controller.dart';
import '../../models/matrix.dart';
import 'block_matrix.dart';
import 'increase_decrease_button.dart';

class MatrixField extends StatelessWidget {

  final String title;
  final int rows;
  final int columns;
  final List<List<TextEditingController>> controllers;
  final Function(int, int) onResize;

  const MatrixField({
    super.key,
    required this.title,
    required this.rows,
    required this.columns,
    required this.controllers,
    required this.onResize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.matrixField,
        border: Border.all(color: AppColors.matrixFieldBorder, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child:
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(rows, (rowIndex) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(columns, (colIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: BlockMatrix(controller: controllers[rowIndex][colIndex]),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildCounter('Rows', rows, (val) => onResize(val, columns)),
              const SizedBox(width: 8),
              const Text('×'),
              const SizedBox(width: 8),
              _buildCounter('Cols', columns, (val) => onResize(rows, val)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        GestureDetector(onTap: () => value < 8 ? onChanged(value + 1) : null, child: IncreaseDecreaseButton('+')),
        Text(value.toString(), style: const TextStyle(fontSize: 18)),
        GestureDetector(onTap: () => value > 1 ? onChanged(value - 1) : null, child: IncreaseDecreaseButton('-')),
      ],
    );
  }
}
