String formatPhoneNumber(String phoneNumber) {
  // Remove any existing formatting
  final cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Apply the desired format (assuming a 10-digit number)
  final formatted = cleaned.replaceAllMapped(
    RegExp(r'(\d{4})(\d{3})(\d{3})'),
    (Match m) => '${m[1]}-${m[2]}-${m[3]}',
  );

  return formatted;
}
