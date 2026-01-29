import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CalculateButton extends StatefulWidget {

  final VoidCallback onTap;

  const CalculateButton({
    super.key,
    required this.onTap,
  });

  @override
  State<CalculateButton> createState() => _CalculateButtonState();
}

class _CalculateButtonState extends State<CalculateButton> {

  bool _isPressed = false;

  void _handleTap() async {
    widget.onTap();
    if (mounted) setState(() => _isPressed = true);
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Stack(
          children: [
            Container(
              width: 182,
              height: 62,
              decoration: BoxDecoration(
                color: AppColors.buttonCalculateShadow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.buttonBorder, width: 1),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              top: _isPressed ? 2 : 1,
              left: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 180,
                height: _isPressed ? 57 : 55,
                decoration: BoxDecoration(
                  color: AppColors.buttonCalculate,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    '= Calculate',
                    style: const TextStyle(
                      color: AppColors.buttonText,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
