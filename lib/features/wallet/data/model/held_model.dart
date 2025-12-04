import 'package:falak/core/functions/format_number.dart';
import 'package:falak/features/wallet/data/model/wallet_details_model.dart';
import 'package:intl/intl.dart';

class HeldModel {
  final List<WalletDetailsModel> data;

  HeldModel({
    required this.data,
  });

  factory HeldModel.fromJson(Map<String, dynamic> json) {
    return HeldModel(
      data: List<WalletDetailsModel>.from(
          json['data'].map((x) => WalletDetailsModel.fromHeldJson(x))),
    );
  }
}
