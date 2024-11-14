import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    super.key,
    this.hintText,
    this.icon,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.keyboardType,
    this.suffixIcon,
    this.hintStyle,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
  });
  final IconData? icon;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool autofocus;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final void Function()? onTap;
  final bool enabled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
          enabled: enabled,
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: hintStyle,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon),
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      autofocus: autofocus,
      keyboardType: keyboardType,
    );
  }
}
