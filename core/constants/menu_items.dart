import 'package:flutter/material.dart';

class MenuItems {
  static const List<DropdownMenuEntry<String>> menuOperations = const [
    DropdownMenuEntry<String>(value: 'Transposition', label: 'Transposition'),
    DropdownMenuEntry<String>(value: 'DeterminantLaplace', label: 'Determinant (Laplace)',),
    DropdownMenuEntry<String>(value: 'DeterminantGauss', label: 'Determinant (Gauss)',),
    DropdownMenuEntry<String>(value: 'MultiplicationByNumber', label: 'Multiplication by number',),
    DropdownMenuEntry<String>(value: 'Addition', label: 'Addition'),
    DropdownMenuEntry<String>(value: 'Subtraction', label: 'Subtraction'),
    DropdownMenuEntry<String>(value: 'Multiplication', label: 'Multiplication'),
  ];

  static const List<DropdownMenuEntry<String>> menuNumberView = const [
    DropdownMenuEntry<String>(value: 'Decimal', label: 'Decimal'),
    DropdownMenuEntry<String>(value: 'Proper', label: 'Proper'),
    DropdownMenuEntry<String>(value: 'Improper', label: 'Improper'),
  ];
}
