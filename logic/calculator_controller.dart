import 'package:flutter/cupertino.dart';

import '../models/matrix.dart';
import '../operations/binary_operations.dart';
import '../operations/unary_operations.dart';

class CalculatorController extends ChangeNotifier {
  int rowsA = 3;
  int colsA = 3;

  int rowsB = 3;
  int colsB = 3;

  String? textException;

  String? selectedOperation;
  Matrix resultMatrix = Matrix([[0]]);

  bool isPressed = false;
  bool hasResult = false;

  final List<List<TextEditingController>> controllersA = List.generate(
    8, (r) => List.generate(8, (c) => TextEditingController()),
  );

  final List<List<TextEditingController>> controllersB = List.generate(
    8, (r) => List.generate(8, (c) => TextEditingController()),
  );

  void updateSize(int r, int c, bool isMatrixA) {
    textException = null;
    if (isMatrixA) {
      rowsA = r; colsA = c;
    } else {
      rowsB = r; colsB = c;
    }
    notifyListeners();
  }

  Matrix getMatrix(int r, int c, List<List<TextEditingController>> ctrls) {
    return Matrix(List.generate(r, (i) => List.generate(c, (j) =>
    double.tryParse(ctrls[i][j].text) ?? 0)));
  }

  void calculate({double multiplier = 1.0}) {
    textException = null;
    Matrix matrixA = getMatrix(rowsA, colsA, controllersA);
    try {
      switch(selectedOperation) {
        case 'Transposition':
          resultMatrix = MatrixTransposition(matrixA).operation();
          break;
        case 'DeterminantLaplace':
          resultMatrix = MatrixDeterminantLaplace(matrixA).operation();
          break;
        case 'DeterminantGauss':
          resultMatrix = MatrixDeterminantGauss(matrixA).operation();
          break;
        case 'MultiplicationByNumber':
          resultMatrix = MatrixMultiplicationByNumber(matrixA, multiplier).operation();
          break;
        case 'Addition':
          Matrix matrixB = getMatrix(rowsB, colsB, controllersB);
          resultMatrix = MatrixAddition(matrixA, matrixB).operation();
          break;
        case 'Subtraction':
          Matrix matrixB = getMatrix(rowsB, colsB, controllersB);
          resultMatrix = MatrixSubtraction(matrixA, matrixB).operation();
          break;
        case 'Multiplication':
          Matrix matrixB = getMatrix(rowsB, colsB, controllersB);
          resultMatrix = MatrixMultiplication(matrixA, matrixB).operation();
          break;
      }
    } catch (e) {
      textException = e.toString().replaceFirst('Exception: ', 'Error: ');
    }
    hasResult = true;
    notifyListeners();
  }

  void changeMatrix() {
    textException = null;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        String tempText = controllersA[i][j].text;
        controllersA[i][j].text = controllersB[i][j].text;
        controllersB[i][j].text = tempText;
      }
    }
    int tmpRows = rowsA;
    rowsA = rowsB;
    rowsB = tmpRows;

    int tmpCols = colsA;
    colsA = colsB;
    colsB = tmpCols;
    notifyListeners();
  }

  @override
  void dispose() {
    for (var row in controllersA) {
      for (var c in row) {
        c.dispose();
      }
    }
    for (var row in controllersB) {
      for (var c in row) {
        c.dispose();
      }
    }
    super.dispose();
  }
}
