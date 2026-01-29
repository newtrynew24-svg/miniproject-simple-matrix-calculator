import 'package:flutter/material.dart';
import 'package:simple_matrix_calculator/core/constants/app_colors.dart';
import 'package:simple_matrix_calculator/presentation/screens/screen_matrix_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),
      home: ScreenMatrixCalculator(),
    );
  }
}

