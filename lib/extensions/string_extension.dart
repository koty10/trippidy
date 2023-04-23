extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
  }
}
