import '../models/matrix.dart';
import 'base_operations.dart';

class MatrixAddition extends BinaryOperation {
  MatrixAddition(Matrix matrixLeft, Matrix matrixRight)
    : super(matrixLeft, matrixRight);

  @override
  Matrix operation() {
    if (matrixLeft.rows != matrixRight.rows ||
        matrixLeft.cols != matrixRight.cols) {
      throw Exception(
        'Matrices must have the same dimensions for this operation.',
      );
    }
    List<List<double>> result = [];
    for (int i = 0; i < matrixLeft.rows; ++i) {
      List<double> row = [];
      for (int j = 0; j < matrixLeft.cols; ++j) {
        row.add(matrixLeft.data[i][j] + matrixRight.data[i][j]);
      }
      result.add(row);
    }
    return Matrix(result);
  }
}

class MatrixSubtraction extends BinaryOperation {
  MatrixSubtraction(Matrix matrixLeft, Matrix matrixRight)
    : super(matrixLeft, matrixRight);

  @override
  Matrix operation() {
    if (matrixLeft.rows != matrixRight.rows ||
        matrixLeft.cols != matrixRight.cols) {
      throw Exception(
        'Matrices must have the same dimensions for this operation.',
      );
    }
    List<List<double>> result = [];
    for (int i = 0; i < matrixLeft.rows; ++i) {
      List<double> row = [];
      for (int j = 0; j < matrixLeft.cols; ++j) {
        row.add(matrixLeft.data[i][j] - matrixRight.data[i][j]);
      }
      result.add(row);
    }
    return Matrix(result);
  }
}

class MatrixMultiplication extends BinaryOperation {
  MatrixMultiplication(Matrix matrixLeft, Matrix matrixRight)
    : super(matrixLeft, matrixRight);

  @override
  Matrix operation() {
    if (matrixLeft.cols != matrixRight.rows) {
      throw Exception(
        'The number of columns in Matrix A must equal the number of rows in Matrix B.',
      );
    }
    List<List<double>> resultMatrix = [];
    for (int i = 0; i < matrixLeft.rows; ++i) {
      List<double> row = [];
      for (int j = 0; j < matrixRight.cols; ++j) {
        double sum = 0;
        for (int k = 0; k < matrixLeft.cols; ++k) {
          sum += matrixLeft.data[i][k] * matrixRight.data[k][j];
        }
        row.add(sum);
      }
      resultMatrix.add(row);
    }
    return Matrix(resultMatrix);
  }
}
