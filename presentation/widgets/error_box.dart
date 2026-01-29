import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String? textException;

  const ErrorBox({super.key, this.textException});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: textException != null ? 1 : 0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: textException != null
            ? Padding(
                key: const ValueKey('error_content'),
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(48),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withAlpha(128)),
                  ),
                  child: Text(
                    textException!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : const SizedBox.shrink(key: ValueKey('error_empty')),
      ),
    );
  }
}
