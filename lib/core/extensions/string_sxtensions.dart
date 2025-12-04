import 'package:falak/core/utils/app_logger.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/features/wallet/data/model/wallet_details_model.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/animation.dart';

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

  bool get isEmailValid {
    if (this == null || this!.isEmpty) {
      return false;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(this!);
  }

  String get icon {
    switch (this) {
      case AppStrings.rejected:
        return Assets.appImagesRejected;
      case AppStrings.pending:
        return Assets.appImagesPindding;
      case AppStrings.blocked:
        return Assets.appImagesCanceled;
      case AppStrings.approved:
        return Assets.appImagesActiveSvg;
      default:
        return Assets.appImagesTerminated;
    }
  }

  String get title {
    switch (this) {
      case AppStrings.rejected:
        return 'مرفوض';
      case AppStrings.pending:
        return 'تحت الإجراء';
      case AppStrings.blocked:
        return 'ملغي';
      case AppStrings.approved:
        return 'نشط';
      default:
        return 'منتهية';
    }
  }

  Color get bgColor {
    switch (this) {
      case AppStrings.rejected:
        return const Color(0xffFDF4F3);
      case AppStrings.pending:
        return const Color(0x1AF2994A);
      case AppStrings.blocked:
        return const Color(0xffF9FAFA);
      case AppStrings.approved:
        return const Color(0xffF3FBEE);
      default:
        return const Color(0xffFDF4F3);
    }
  }

  Color get borderColor {
    switch (this) {
      case AppStrings.rejected:
        return const Color(0xffFCD0CC);
      case AppStrings.pending:
        return const Color(0x66F2994A);
      case AppStrings.blocked:
        return const Color(0xffDCDEDE);
      case AppStrings.approved:
        return const Color(0xff009951);
      default:
        return const Color(0xffFCD0CC);
    }
  }

  Color get textColor {
    switch (this) {
      case AppStrings.rejected:
        return const Color(0xffD54033);
      case AppStrings.pending:
        return const Color(0xff9E5C21);
      case AppStrings.blocked:
        return const Color(0xff666E6D);
      case AppStrings.approved:
        return const Color(0xff009951);
      default:
        return const Color(0xffD54033);
    }
  }

  TransactionStatus fromType(WalletType type) {
    switch (type) {
      case WalletType.charge:
        return TransactionStatus.values.firstWhere(
          (status) => status.name == this!.toLowerCase(),
          orElse: () => TransactionStatus.failed,
        );
      case WalletType.withdraw:
        switch (this) {
          case 'pending':
            return TransactionStatus.pending;
          case 'rejected':
            return TransactionStatus.failed;
          case 'inProgress':
            return TransactionStatus.confirmed;
          default:
            return TransactionStatus.success;
        }
      case WalletType.other:
        return TransactionStatus.values.firstWhere(
          (status) => status.name == this!.toLowerCase(),
          orElse: () => TransactionStatus.failed,
        );
    }
  }
}
