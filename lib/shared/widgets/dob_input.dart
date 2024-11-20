import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthDateInput extends StatefulWidget {
  final Function(String) onDateChanged; // Callback for parent widget

  const BirthDateInput({super.key, required this.onDateChanged});

  @override
  State createState() => _BirthDateInputState();
}

class _BirthDateInputState extends State<BirthDateInput> {
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  final FocusNode dayFocusNode = FocusNode();
  final FocusNode monthFocusNode = FocusNode();
  final FocusNode yearFocusNode = FocusNode();

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    dayFocusNode.dispose();
    monthFocusNode.dispose();
    yearFocusNode.dispose();
    super.dispose();
  }

  // This method gets the input values and returns them
  String getDateInput() {
    String day =
        dayController.text.padLeft(2, '0'); // Ensure two digits for day
    String month =
        monthController.text.padLeft(2, '0'); // Ensure two digits for month
    String year = yearController.text;

    // Here, return a formatted string (you can change this as needed)
    return '$day/$month/$year';
  }

  // Call this method when the input changes
  void onInputChanged() {
    String date = getDateInput();
    widget.onDateChanged(date); // Pass the date back to the parent widget
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDateField(
            controller: dayController,
            hint: 'DD',
            maxLength: 2,
            focusNode: dayFocusNode,
            nextFocusNode: monthFocusNode,
            onChanged: onInputChanged,
          ),
          const Text(' | ', style: TextStyle(color: Colors.grey)),
          _buildDateField(
            controller: monthController,
            hint: 'MM',
            maxLength: 2,
            focusNode: monthFocusNode,
            nextFocusNode: yearFocusNode,
            onChanged: onInputChanged,
          ),
          const Text(' | ', style: TextStyle(color: Colors.grey)),
          _buildDateField(
            controller: yearController,
            hint: 'YYYY',
            maxLength: 4,
            focusNode: yearFocusNode,
            nextFocusNode: null,
            onChanged: onInputChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String hint,
    required int maxLength,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    required Function() onChanged,
  }) {
    return SizedBox(
      width: maxLength == 2 ? 40 : 60, // Adjust width based on maxLength
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: hint == 'DD', // Autofocus only for the day (DD) field
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        onChanged: (value) {
          if (value.length == maxLength && nextFocusNode != null) {
            FocusScope.of(context)
                .requestFocus(nextFocusNode); // Move to the next field
          }
          onChanged(); // Notify that input has changed
        },
      ),
    );
  }
}
