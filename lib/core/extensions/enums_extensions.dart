import 'package:falak/features/wallet/data/model/wallet_details_model.dart';
import 'package:flutter/animation.dart';

extension TransactionExtensions on TransactionStatus {
  String title(WalletType type) {
    switch (type) {
      case WalletType.charge:
        switch (this) {
          case TransactionStatus.pending:
            return 'العملية  معلقة';
          case TransactionStatus.confirmed:
            return 'تم التصديق علي الفاتورة';
          case TransactionStatus.failed:
            return 'عملية فاشلة';
          case TransactionStatus.success:
            return 'ناجحة';
        }
      case WalletType.withdraw:
        switch (this) {
          case TransactionStatus.pending:
            return 'تم إرسال الطلب';
          case TransactionStatus.confirmed:
            return 'تحت الإجراء';
          case TransactionStatus.failed:
            return 'عملية فاشلة';
          case TransactionStatus.success:
            return 'عملية ناجحة';
        }
      case WalletType.other:
        switch (this) {
          case TransactionStatus.pending:
            return 'تم إرسال الطلب';
          case TransactionStatus.confirmed:
            return 'تحت الإجراء';
          case TransactionStatus.failed:
            return 'عملية فاشلة';
          case TransactionStatus.success:
            return 'عملية ناجحة';
        }
    }
  }

  Color get bgColor {
    switch (this) {
      case TransactionStatus.pending:
        return const Color(0xfff9fafa);

      case TransactionStatus.confirmed:
        return const Color(0x1AF2994A);

      case TransactionStatus.failed:
        return const Color(0xffFDF4F3);

      case TransactionStatus.success:
        return const Color(0xffF3FBEE);
    }
  }

  Color get borderColor {
    switch (this) {
      case TransactionStatus.pending:
        return const Color(0xffdcdede);

      case TransactionStatus.confirmed:
        return const Color(0x66F2994A);

      case TransactionStatus.failed:
        return const Color(0xffFCD0CC);

      case TransactionStatus.success:
        return const Color(0xff009951);
    }
  }

  Color get textColor {
    switch (this) {
      case TransactionStatus.pending:
        return const Color(0xff666e6d);

      case TransactionStatus.confirmed:
        return const Color(0xff9E5C21);

      case TransactionStatus.failed:
        return const Color(0xffD54033);

      case TransactionStatus.success:
        return const Color(0xff009951);
    }
  }
}
