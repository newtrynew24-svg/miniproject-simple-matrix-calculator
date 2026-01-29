import 'dart:math' as math;

class Fraction {
  final int numerator;
  final int denominator;

  Fraction(this.numerator, this.denominator);

  factory Fraction.fromDouble(double value) {
    String valStr = value.toString();
    if (!valStr.contains('.')) return Fraction(value.toInt(), 1);
    int digitsAfterComma = valStr.split('.')[1].length;
    int denominator = math.pow(10, digitsAfterComma).toInt();
    int numerator = (value * denominator).round();

    return Fraction(numerator, denominator).reduce();
  }

  Fraction reduce() {
    int common = _gcd(numerator.abs(), denominator.abs());
    return Fraction(numerator ~/ common, denominator ~/ common);
  }

  int _gcd(int a, int b) {
    return b == 0 ? a : _gcd(b, a % b);
  }

  Fraction operator +(Fraction other) {
    int newNumerator =
        numerator * other.denominator + other.numerator * denominator;
    int newDenominator = denominator * other.denominator;
    return Fraction(newNumerator, newDenominator).reduce();
  }

  Fraction operator -(Fraction other) {
    int newNumerator =
        numerator * other.denominator - other.numerator * denominator;
    int newDenominator = denominator * other.denominator;
    return Fraction(newNumerator, newDenominator).reduce();
  }

  Fraction operator *(Fraction other) {
    return Fraction(
      numerator * other.numerator,
      denominator * other.denominator,
    ).reduce();
  }

  Fraction operator /(Fraction other) {
    if (other.numerator == 0) throw Exception("Division by zero");
    return Fraction(
      numerator * other.denominator,
      denominator * other.numerator,
    ).reduce();
  }

  Fraction operator -() {
    return Fraction(-numerator, denominator);
  }

  double toDouble() {
    return numerator / denominator;
  }
}
