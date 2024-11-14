import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:zaccount/utils/constants.dart";

class TextFieldWithIcon extends StatelessWidget {
  const TextFieldWithIcon({
    super.key,
    required this.hintText,
    required this.icon,
    this.autofocus = false,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
  });
  final String hintText;
  final IconData icon;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: lightGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 10),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
      autofocus: autofocus,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}
