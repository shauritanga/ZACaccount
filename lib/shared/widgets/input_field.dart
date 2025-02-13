import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    this.onSaved,
    required this.icon,
    required this.hintText,
    this.validator,
    this.inputFormatters,
    this.onChanged,
  });

  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget icon;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
    );
  }
}
