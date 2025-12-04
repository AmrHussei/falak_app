import 'package:equatable/equatable.dart';
import 'package:falak/core/extensions/enums_extensions.dart';
import 'package:falak/core/extensions/string_sxtensions.dart';
import 'package:intl/intl.dart';

class WalletDetailsModel extends Equatable {
  final String title;
  final String amount;
  final String transactionDate;
  final String transactionTime;
  final String refNumber;
  final TransactionStatus status;

  const WalletDetailsModel({
    required this.amount,
    required this.transactionDate,
    required this.transactionTime,
    required this.refNumber,
    required this.status,
    required this.title,
  });

  factory WalletDetailsModel.fromInvoiceJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['IssueDate']);
    return WalletDetailsModel(
      title: 'طلب شحن رصيد',
      refNumber: json['_id'],
      transactionDate: '${DateFormat('dd, MMMM, yyyy').format(date.toLocal())}',
      transactionTime: '${DateFormat('hh:mm a').format(date.toLocal())}',
      amount: json['TotalAmount'],
      status: json['status'].toString().fromType(WalletType.charge),
    );
  }

  factory WalletDetailsModel.fromWithdrawJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['createdAt']);
    return WalletDetailsModel(
      title: 'طلب سحب رصيد',
      refNumber: json['_id'],
      transactionDate: '${DateFormat('dd, MMMM, yyyy').format(date.toLocal())}',
      transactionTime: '${DateFormat('hh:mm a').format(date.toLocal())}',
      amount: json['amount'],
      status: json['status'].toString().fromType(WalletType.withdraw),
    );
  }

  factory WalletDetailsModel.fromHeldJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['createdAt']);
    final status = json['status'].toString().fromType(WalletType.other);
    return WalletDetailsModel(
      amount: json['amount'] ?? 0,
      status: status,
      title: 'حجز عربون ${json['enrollment']?['auction']?['title']??''}',
      refNumber: json['_id'],
      transactionDate: '${DateFormat('dd, MMMM, yyyy').format(date.toLocal())}',
      transactionTime: '${DateFormat('hh:mm a').format(date.toLocal())}',
    );
  }

  @override
  List<Object?> get props => [
    amount,
    transactionDate,
    transactionTime,
    refNumber,
    status,
    title,
  ];
}

enum WalletType { charge, withdraw, other }

enum TransactionStatus { pending, confirmed, failed, success }
