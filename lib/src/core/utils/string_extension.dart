extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }

  String capitalizeAll() {
    return split(' ').map((e) => e.capitalize()).join(' ');
  }

  String phoneFormat() {
    final phone = removeNonDigits();
    if (phone.length == 11) {
      return '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7)}';
    } else if (phone.length == 10) {
      return '(${phone.substring(0, 2)}) ${phone.substring(2, 6)}-${phone.substring(6)}';
    } else {
      return this;
    }
  }

  String removeNonDigits() {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }
}
