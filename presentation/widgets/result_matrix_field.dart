import 'package:flutter/material.dart';
import 'package:simple_matrix_calculator/models/fraction.dart';
import 'package:simple_matrix_calculator/models/matrix.dart';

import '../../core/constants/app_colors.dart';

class ResultMatrixField extends StatefulWidget {
  final Matrix matrix;
  final String numberView;

  const ResultMatrixField(this.matrix, this.numberView, {super.key});

  @override
  State<ResultMatrixField> createState() => _ResultMatrixFieldState();
}

class _ResultMatrixFieldState extends State<ResultMatrixField> {

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
            'Result',
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
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: List.generate(widget.matrix.rows, (rowIndex) {
                  return TableRow(
                    children: List.generate(widget.matrix.cols, (colIndex) {
                      final value = widget.matrix.data[rowIndex][colIndex];
                      Fraction fraction = Fraction.fromDouble(value);
                      return TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: switch(widget.numberView) {
                                'Decimal' => Text(
                                  formatNumber(value),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.textColor,
                                    ),
                                ),
                                'Improper' => buildFraction(fraction),
                                'Proper' => buildProperFraction(fraction),
                                _ => Text(value.toString()),
                              },
                            ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }

  Widget buildFraction(Fraction fraction) {
    if (fraction.denominator == 1) {
      return Text(
        formatNumber(fraction.numerator.toDouble()),
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: AppColors.textColor
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          fraction.numerator.toString(),
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: AppColors.textColor
          ),
        ),
        Container(
          width: 12,
          height: 1,
          color: AppColors.textColor,
        ),
        Text(
          fraction.denominator.toString(),
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: AppColors.textColor
          ),
        ),
      ],
    );
  }

  Widget buildProperFraction(Fraction fraction) {
    if (fraction.denominator == 1) {
      return Text(
          formatNumber(fraction.numerator.toDouble()),
        style: TextStyle(
            fontSize: 16,
            color: AppColors.textColor
        ),
      );
    }
    int wholePart = fraction.numerator ~/ fraction.denominator;
    int remNum = fraction.numerator.abs() % fraction.denominator;

    if (remNum == 0) {
      return Text(
          wholePart.toString(),
          style: const TextStyle(
              fontSize: 16,
              color: AppColors.textColor
          )
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (wholePart != 0)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              wholePart.toString(),
              style: TextStyle(fontSize: 16, color: AppColors.textColor),
            ),
          ),
        buildFraction(Fraction(remNum, fraction.denominator)),
      ],
    );
  }

  String formatNumber(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }

}
