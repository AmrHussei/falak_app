// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.auctionBrochureRequestState = RequestState.ideal,
    this.auctionBrochureError,
    this.auctionBrochureMsg,
    this.privacyPolicyRequestState = RequestState.ideal,
    this.privacyPolicyError,
    this.privacyPolicyModel,
    this.favoriteRequestState = RequestState.ideal,
    this.getWalletRequestState = RequestState.ideal,
    this.getWalletError,
    this.getWalletModel,
    this.addWalletBalanceRequestState = RequestState.ideal,
    this.addWalletBalanceError,
    this.addWalletBalanceMsg,
    this.propertyPrice = 0,
    this.transactionFee = 0,
    this.commission = 0,
    this.commissionTax = 0,
    this.total = 0,
    this.topBid = 0,
    this.auctionEnrollmentRequestState = RequestState.ideal,
    this.auctionEnrollmentError,
    this.auctionEnrollmentMsg,
    this.deleteAuctionEnrollmentRequestState = RequestState.ideal,
    this.deleteAuctionEnrollmentError,
    this.deleteAuctionEnrollmentMsg,
    this.getAuctionBoardRequestState = RequestState.ideal,
    this.getAuctionBoardError,
    this.addAuctionBidRequestState = RequestState.ideal,
    this.addAuctionBidError,
    this.addAuctionBidMsg,
    this.auctionsRequestState=const {} ,
    this.auctionsError=const {},
    this.auctionsModel = const {},
    this.shareAs= AppStrings.enrollShareAsGenuine
  });

  final Map<String,RequestState> auctionsRequestState;
  final Map<String,Failure> auctionsError;
  final Map<String,AuctionsModel> auctionsModel;
  //
  final RequestState favoriteRequestState;
  //
  final RequestState auctionEnrollmentRequestState;
  final Failure? auctionEnrollmentError;
  final String? auctionEnrollmentMsg;
  //
  final RequestState deleteAuctionEnrollmentRequestState;
  final Failure? deleteAuctionEnrollmentError;
  final String? deleteAuctionEnrollmentMsg;
  //
  final RequestState getAuctionBoardRequestState;
  final Failure? getAuctionBoardError;
  //
  final RequestState addAuctionBidRequestState;
  final Failure? addAuctionBidError;
  final String? addAuctionBidMsg;
  //
  final RequestState getWalletRequestState;
  final Failure? getWalletError;
  final WalletModel? getWalletModel;
  //
  final RequestState privacyPolicyRequestState;
  final Failure? privacyPolicyError;
  final PrivacyModel? privacyPolicyModel;
  //
  final RequestState auctionBrochureRequestState;
  final Failure? auctionBrochureError;
  final String? auctionBrochureMsg;
  //
  final RequestState addWalletBalanceRequestState;
  final Failure? addWalletBalanceError;
  final String? addWalletBalanceMsg;
  //
  final double propertyPrice;
  final double transactionFee;
  final double commission;
  final double commissionTax;
  final double total;
  final dynamic topBid;
  final String shareAs;

  @override
  List<Object?> get props => [
        auctionBrochureRequestState,
        auctionBrochureError,
        auctionBrochureMsg,
        privacyPolicyRequestState,
        privacyPolicyError,
        privacyPolicyModel,
        getWalletRequestState,
        getWalletError,
        getWalletModel,
        addWalletBalanceRequestState,
        addWalletBalanceError,
        addWalletBalanceMsg,
        topBid,
        propertyPrice,
        transactionFee,
        commission,
        commissionTax,
        total,
        auctionsRequestState,
        auctionsError,
        auctionsModel,
        auctionEnrollmentRequestState,
        auctionEnrollmentError,
        auctionEnrollmentMsg,
        deleteAuctionEnrollmentRequestState,
        deleteAuctionEnrollmentError,
        deleteAuctionEnrollmentMsg,
        getAuctionBoardRequestState,
        getAuctionBoardError,
        addAuctionBidRequestState,
        addAuctionBidError,
        addAuctionBidMsg,
        shareAs,
      ];

  HomeState copyWith({
     Map<String,RequestState>? auctionsRequestState,
     Map<String,Failure>? auctionsError,
     Map<String,AuctionsModel>? auctionsModel,
    Map<String,RequestState>? getUserAuctionsRequestState,
    Failure? getUserAuctionsError,
    Map<String,AuctionsModel>? getUserAuctionsModel,
    RequestState? auctionEnrollmentRequestState,
    Failure? auctionEnrollmentError,
    String? auctionEnrollmentMsg,
    RequestState? deleteAuctionEnrollmentRequestState,
    Failure? deleteAuctionEnrollmentError,
    String? deleteAuctionEnrollmentMsg,
    RequestState? getAuctionBoardRequestState,
    Failure? getAuctionBoardError,
    AuctionBoardModel? getAuctionBoardModel,
    RequestState? addAuctionBidRequestState,
    Failure? addAuctionBidError,
    String? addAuctionBidMsg,
    RequestState? getWalletRequestState,
    Failure? getWalletError,
    WalletModel? getWalletModel,
    RequestState? privacyPolicyRequestState,
    RequestState? favoriteRequestState,
    Failure? privacyPolicyError,
    PrivacyModel? privacyPolicyModel,
    RequestState? auctionBrochureRequestState,
    Failure? auctionBrochureError,
    String? auctionBrochureMsg,
    RequestState? addWalletBalanceRequestState,
    Failure? addWalletBalanceError,
    String? addWalletBalanceMsg,
    double? propertyPrice,
    double? transactionFee,
    double? commission,
    double? commissionTax,
    double? total,
    dynamic topBid,
    String? shareAs,
  }) {
    return HomeState(
      favoriteRequestState:favoriteRequestState??this.favoriteRequestState,
      auctionsRequestState: auctionsRequestState ?? this.auctionsRequestState,
      auctionsError: auctionsError ?? this.auctionsError,
      auctionsModel: auctionsModel ?? this.auctionsModel,
      auctionEnrollmentRequestState:
          auctionEnrollmentRequestState ?? this.auctionEnrollmentRequestState,
      auctionEnrollmentError:
          auctionEnrollmentError ?? this.auctionEnrollmentError,
      auctionEnrollmentMsg: auctionEnrollmentMsg ?? this.auctionEnrollmentMsg,
      deleteAuctionEnrollmentRequestState:
          deleteAuctionEnrollmentRequestState ??
              this.deleteAuctionEnrollmentRequestState,
      deleteAuctionEnrollmentError:
          deleteAuctionEnrollmentError ?? this.deleteAuctionEnrollmentError,
      deleteAuctionEnrollmentMsg:
          deleteAuctionEnrollmentMsg ?? this.deleteAuctionEnrollmentMsg,
      getAuctionBoardRequestState:
          getAuctionBoardRequestState ?? this.getAuctionBoardRequestState,
      getAuctionBoardError: getAuctionBoardError ?? this.getAuctionBoardError,
      addAuctionBidRequestState:
          addAuctionBidRequestState ?? this.addAuctionBidRequestState,
      addAuctionBidError: addAuctionBidError ?? this.addAuctionBidError,
      addAuctionBidMsg: addAuctionBidMsg ?? this.addAuctionBidMsg,
      getWalletRequestState:
          getWalletRequestState ?? this.getWalletRequestState,
      getWalletError: getWalletError ?? this.getWalletError,
      getWalletModel: getWalletModel ?? this.getWalletModel,
      privacyPolicyRequestState:
          privacyPolicyRequestState ?? this.privacyPolicyRequestState,
      privacyPolicyError: privacyPolicyError ?? this.privacyPolicyError,
      privacyPolicyModel: privacyPolicyModel ?? this.privacyPolicyModel,
      auctionBrochureRequestState:
          auctionBrochureRequestState ?? this.auctionBrochureRequestState,
      auctionBrochureError: auctionBrochureError ?? this.auctionBrochureError,
      auctionBrochureMsg: auctionBrochureMsg ?? this.auctionBrochureMsg,
      addWalletBalanceRequestState:
          addWalletBalanceRequestState ?? this.addWalletBalanceRequestState,
      addWalletBalanceError:
          addWalletBalanceError ?? this.addWalletBalanceError,
      addWalletBalanceMsg: addWalletBalanceMsg ?? this.addWalletBalanceMsg,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      transactionFee: transactionFee ?? this.transactionFee,
      commission: commission ?? this.commission,
      commissionTax: commissionTax ?? this.commissionTax,
      total: total ?? this.total,
      topBid: topBid ?? this.topBid,
      shareAs: shareAs ?? this.shareAs,
    );
  }
}
