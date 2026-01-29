class Matrix {
  final List<List<double>> data;
  final int rows;
  final int cols;

  Matrix(this.data) : rows = data.length, cols = data[0].length;
}
