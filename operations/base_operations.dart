import '../models/matrix.dart';

abstract class MatrixOperation {
  Matrix operation();
}

abstract class UnaryOperation implements MatrixOperation {
  final Matrix matrix;
  UnaryOperation(this.matrix);
}

abstract class BinaryOperation implements MatrixOperation {
  final Matrix matrixLeft;
  final Matrix matrixRight;
  BinaryOperation(this.matrixLeft, this.matrixRight);
}
