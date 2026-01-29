import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class SwapButton extends StatefulWidget {

  final VoidCallback onTap;

  const SwapButton({
    super.key,
    required this.onTap,
  });

  @override
  State<SwapButton> createState() => _SwapButtonState();
}

class _SwapButtonState extends State<SwapButton> {

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
            height: 50,
            width: 94,
            decoration: BoxDecoration(
              color: AppColors.buttonChangeShadow,
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
              height: _isPressed ? 46 : 44,
              width: 92,
              decoration: BoxDecoration(
                color: AppColors.buttonChange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Swap',
                  style: TextStyle(
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
