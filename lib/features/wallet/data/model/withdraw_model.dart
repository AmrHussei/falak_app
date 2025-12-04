import 'package:falak/features/wallet/data/model/wallet_details_model.dart';

class WithdrawModel {
  final List<WalletDetailsModel> data;

  WithdrawModel({required this.data});

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => WalletDetailsModel.fromWithdrawJson(e))
          .toList(),
    );
  }
}
