import 'package:falak/core/utils/app_logger.dart';

extension StringExtensions on String? {
  String getLast(int count) {
    AppLogger.debug('Getting last $count characters from: $this');

    // Return empty string if null
    if (this == null) {
      return '';
    }

    // Return empty string if count is invalid
    if (count <= 0) {
      return '';
    }

    // If string length is less than or equal to count, return the whole string
    if (this!.length <= count) {
      return this!;
    }

    // Return the last 'count' characters
    return this!.substring(this!.length - count);
  }

  bool get validateNationalId {
    return !(this == null ||
        this!.isEmpty ||
        this!.length < 10 ||
        (this![0] != '1' && this![0] != '2'));
  }
}
