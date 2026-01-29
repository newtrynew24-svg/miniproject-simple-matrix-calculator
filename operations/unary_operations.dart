import '../models/fraction.dart';
import '../models/matrix.dart';
import 'base_operations.dart';

class MatrixTransposition extends UnaryOperation {

  MatrixTransposition(Matrix matrix) : super(matrix);

  @override
  Matrix operation() {
    List<List<double>> newMatrix = [];
    for(int i = 0; i < matrix.cols; ++i) {
      List<double> newRow = [];
      for(int j = 0; j < matrix.rows; ++j) {
        newRow.add(matrix.data[j][i]);
      }
      newMatrix.add(newRow);
    }
    return Matrix(newMatrix);
  }

}

class MatrixDeterminantLaplace extends UnaryOperation {

  MatrixDeterminantLaplace(Matrix matrix) : super(matrix);

  Fraction _compute(List<List<Fraction>> data) {
    int n = data.length;

    if(n == 1) return data[0][0];
    if(n == 2) return data[0][0] * data[1][1] - data[0][1] * data[1][0];

    Fraction det = Fraction(0, 1);
    for(int i = 0; i < n; ++i) {
      Fraction sign = (i % 2 == 0) ? Fraction(1, 1) : Fraction(-1, 1);
      det = det + (sign * data[0][i] * _compute(_getMinor(data, 0, i)));
    }
    return det;
  }

  List<List<Fraction>> _getMinor(List<List<Fraction>> data, int row, int col) {
    int n = data.length;
    List<List<Fraction>> minor = [];
    for (int i = 0; i < n; i++) {
      if (i == row) continue;
      List<Fraction> newRow = [];
      for (int j = 0; j < n; j++) {
        if (j == col) continue;
        newRow.add(data[i][j]);
      }
      minor.add(newRow);
    }
    return minor;
  }

  @override
  Matrix operation() {
    if (matrix.rows != matrix.cols) {
      throw Exception('Matrix must be square.');
    }
    List<List<Fraction>> fractionData = [];
    for(int i = 0; i < matrix.rows; ++i) {
      List<Fraction> row = [];
      for(int j = 0; j < matrix.cols; ++j) {
        row.add(Fraction.fromDouble(matrix.data[i][j]));
      }
      fractionData.add(row);
    }
    Fraction resultFraction = _compute(fractionData);
    return Matrix([[resultFraction.toDouble()]]);
  }

}

class MatrixDeterminantGauss extends UnaryOperation {

  MatrixDeterminantGauss(Matrix matrix) : super(matrix);

  @override
  Matrix operation() {
    if (matrix.rows != matrix.cols) {
      throw Exception('Matrix must be square.');
    }

    int n = matrix.rows;

    List<List<Fraction>> data = [];

    for(int i = 0; i < n; ++i) {
      List<Fraction> row = [];
      for(int j = 0; j < n; ++j) {
        row.add(Fraction.fromDouble(matrix.data[i][j]));
      }
      data.add(row);
    }

    Fraction det = Fraction(1, 1);
    bool signChanged = false;

    for (int i = 0; i < n; i++) {
      int pivot = i;
      while (pivot < n && data[pivot][i].numerator == 0) {
        pivot++;
      }
      if (pivot == n) return Matrix([[Fraction(0, 1).toDouble()]]);
      if (pivot != i) {
        var temp = data[i];
        data[i] = data[pivot];
        data[pivot] = temp;
        signChanged = !signChanged;
      }
      for (int j = i + 1; j < n; j++) {
        Fraction factor = data[j][i] / data[i][i];
        for (int k = i; k < n; k++) {
          data[j][k] = data[j][k] - (factor * data[i][k]);
        }
      }
      det = det * data[i][i];
    }

    double finalDet = det.toDouble();
    if (signChanged) finalDet = -finalDet;

    return Matrix([[finalDet]]);
  }
}

class MatrixMultiplicationByNumber extends UnaryOperation {

  final double number;

  MatrixMultiplicationByNumber(Matrix matrix, this.number) : super(matrix);

  @override
  Matrix operation() {
    List<List<double>> resultData = [];
    for(int i = 0; i < matrix.rows; ++i) {
      List<double> row = [];
      for(int j = 0; j < matrix.cols; ++j) {
        row.add(matrix.data[i][j] * number);
      }
      resultData.add(row);
    }
    return Matrix(resultData);
  }

}
