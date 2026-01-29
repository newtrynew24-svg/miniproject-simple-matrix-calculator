import 'package:flutter/material.dart';

class DropdownRow extends StatelessWidget {

  final String initialSelection;
  final List<DropdownMenuEntry<String>> entries;
  final ValueChanged<String?> onSelected;

  const DropdownRow({
    super.key,
    required this.initialSelection,
    required this.entries,
    required this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: initialSelection,
      dropdownMenuEntries: entries,
      requestFocusOnTap: false,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withAlpha(192),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        side: WidgetStateProperty.all(BorderSide.none),
      ),
      onSelected: onSelected,
    );
  }
}
