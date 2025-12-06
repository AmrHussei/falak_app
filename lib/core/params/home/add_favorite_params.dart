import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GeneralAuctionParams extends Equatable {
  String auctionId;
  String? originId;
  int? limit;
  dynamic amount;

  GeneralAuctionParams({
    required this.auctionId,
     this.originId,
     this.amount,
     this.limit,
  });

  @override
  List<Object?> get props => [
        auctionId,
        originId,
        amount,
        limit,
      ];
}
