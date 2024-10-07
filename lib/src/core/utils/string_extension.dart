extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }

  String capitalizeAll() {
    return split(' ').map((e) => e.capitalize()).join(' ');
  }

  String phoneFormat() {
    return removeNonDigits()
        .replaceAllMapped(RegExp(r'^(\d{2})(\d{5})(\d{4})$'), (match) {
      return '(${match[1]}) ${match[2]}-${match[3]}';
    });
  }

  String removeNonDigits() {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }
}
