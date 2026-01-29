import 'package:flutter/material.dart';
import 'package:simple_matrix_calculator/presentation/widgets/calculate_button.dart';
import 'package:simple_matrix_calculator/presentation/widgets/matrix_field.dart';
import 'package:simple_matrix_calculator/presentation/widgets/result_matrix_field.dart';
import 'package:simple_matrix_calculator/presentation/widgets/swap_button.dart';

import '../../core/constants/menu_items.dart';
import '../../logic/calculator_controller.dart';
import '../widgets/dropdown_row.dart';
import '../widgets/error_box.dart';
import '../widgets/scalar_section.dart';

class ScreenMatrixCalculator extends StatefulWidget {
  const ScreenMatrixCalculator({super.key});

  @override
  State<ScreenMatrixCalculator> createState() => _ScreenMatrixCalculatorState();
}

class _ScreenMatrixCalculatorState extends State<ScreenMatrixCalculator> {

  final CalculatorController _controller = CalculatorController();
  final _textControllerForNumber = TextEditingController();
  String _currentOperation = MenuItems.menuOperations[0].value;
  String _currentNumberView = MenuItems.menuNumberView[0].value;

  @override
  void initState() {
    super.initState();
    _controller.selectedOperation = _currentOperation;
  }

  @override
  void dispose() {
    _textControllerForNumber.dispose();
    super.dispose();
  }

  bool get _isBinaryOperation =>
      ['Addition', 'Subtraction', 'Multiplication'].contains(_currentOperation);

  bool get _isScalarOperation => _currentOperation == 'MultiplicationByNumber';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  ErrorBox(textException: _controller.textException),
                  const SizedBox(height: 6),
                  MatrixField(
                    title: 'Matrix A',
                    rows: _controller.rowsA,
                    columns: _controller.colsA,
                    controllers: _controller.controllersA,
                    onResize: (r, c) => _controller.updateSize(r, c, true),
                  ),
                  _buildScalarSection(),
                  _buildMatrixBSection(),
                  const SizedBox(height: 32),
                  _buildDropdownRow(_currentOperation, MenuItems.menuOperations, (val) {
                    setState(() {
                      _controller.selectedOperation = val;
                      _currentOperation = val!;
                    });
                  }),
                  const SizedBox(height: 16),
                  _buildDropdownRow(_currentNumberView, MenuItems.menuNumberView, (val) {
                    setState(() => _currentNumberView = val!);
                  }),
                  const SizedBox(height: 32),
                  Center(
                    child: CalculateButton(
                      onTap: () {
                        double multiplier =
                            double.tryParse(_textControllerForNumber.text) ??
                            1.0;
                        _controller.calculate(multiplier: multiplier);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildResultSection(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScalarSection() {
    if (!_isScalarOperation) return const SizedBox.shrink();
    return AnimatedOpacity(
      key: const ValueKey('scalar_input'),
      duration: const Duration(milliseconds: 150),
      opacity: 1,
      curve: Curves.easeInOut,
      child: ScalarSection(controller: _textControllerForNumber),
    );
  }

  Widget _buildMatrixBSection() {
    if (!_isBinaryOperation) return const SizedBox.shrink();
    return AnimatedOpacity(
      key: const ValueKey('matrix_b_content'),
      duration: const Duration(milliseconds: 300),
      opacity: 1,
      child: Column(
        children: [
          const SizedBox(height: 16),
          SwapButton(
            onTap: () => _controller.changeMatrix(),
          ),
          const SizedBox(height: 16),
          MatrixField(
            title: 'Matrix B',
            rows: _controller.rowsB,
            columns: _controller.colsB,
            controllers: _controller.controllersB,
            onResize: (r, c) => _controller.updateSize(r, c, false),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(
    String initialSelection,
    List<DropdownMenuEntry<String>> entries,
    ValueChanged<String?> onSelected,
  ) {
    return Center(
      child: DropdownRow(
        initialSelection: initialSelection,
        entries: entries,
        onSelected: onSelected,
      ),
    );
  }

  Widget _buildResultSection() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: _controller.hasResult ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: ResultMatrixField(_controller.resultMatrix, _currentNumberView!),
      ),
    );
  }
}
