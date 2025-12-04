import 'package:falak/features/wallet/data/model/wallet_details_model.dart';

class InvoiceModel {
  final List<WalletDetailsModel> data;

  InvoiceModel({required this.data});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      data: List<WalletDetailsModel>.from(
        json['data'].map((x) => WalletDetailsModel.fromInvoiceJson(x)),
      ),
    );
  }
}
