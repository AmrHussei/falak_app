import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:falak/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:falak/core/params/home/auctions_params.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/features/home/data/models/enrolle/privacy_model.dart';
import 'package:falak/features/home/data/repository/home_repo.dart';

import '../../../../../app/injector.dart';
import '../../../../../core/api/end_point.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/functions/url_luncher.dart';
import '../../../../../core/params/home/add_favorite_params.dart';
import '../../../../../core/params/home/auction_enrollment_params.dart';
import '../../../../../core/storage/i_app_local_storage.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../wallet/data/model/add_wallet_balance.dart';
import '../../../data/models/auctions_model/auctions_model.dart';
import '../../../data/models/enrolle/auction_board_model.dart' hide Pagination;
import '../../../data/socket/auction_board_socket.dart';
import '../../../data/models/setting_model.dart';

part 'home_state.dart';

String KoriginId = '';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeState());

  final HomeRepository _homeRepository;
  SettingsModel? settingsModel;
  AuctionData? auctionData;
  AuctionOrigin? auctionOrigin;
  List<AuctionOrigin> originList = [];
  TextEditingController originSearch = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController auctionFilterSearch = TextEditingController();

  String auctionId = '';
  String? originId = '';
  double? amount;
  int? limit = 6;
  dynamic garlicDifferencetotalAmount;

  //
  String type = AppStrings.enrolltypeOnline;
  String? filterAuctiontype;
  String? filterAuctiontypeAr;
  String? agencyId;
  List<BiderAuctionData> boardAuctionData = [];
  final auctionBoardSocket = AuctionBoardSocket();
  final addBalanceKey = GlobalKey<FormState>();

  Future<void> getAuctions({
    String type = AppStrings.auctionsInProgress,
    bool refresh = false,
  }) async {
    final cachedModel = Map<String, AuctionsModel>.from(state.auctionsModel);

    final loadingStats = Map<String, RequestState>.from(
      state.auctionsRequestState,
    );
    if (cachedModel[type] != null && !refresh) {
      // 1. 🚀 Show cached data immediately without loading
      return;
    } else {
      // 2. 🤔 No cache? then show loading state
      loadingStats[type] = RequestState.loading;
      emit(state.copyWith(auctionsRequestState: loadingStats));
    }

    // 3. 🔥 Always fetch from server in background
    AuctionsParams auctionsParams = AuctionsParams(
      status: type,
      search: auctionFilterSearch.text,
      type: filterAuctiontype,
    );
    UserAuctionsParams? userAuctionsParams;
    if (type.contains('false') || type.contains('true')) {
      final list = type.split('_');

      userAuctionsParams = UserAuctionsParams(
        loss: bool.parse(list[1]),
        winner:bool.parse(list.first) ,
      );
    }
    final result = type == AppConstant.favorite
        ? await _homeRepository.getFavorite()
        : userAuctionsParams != null
        ? await _homeRepository.getUserAuctions(userAuctionsParams)
        : await _homeRepository.getAuctions(auctionsParams);

    result.fold(
      (failure) {
        // Only show error if no cache existed (first time)
        final auctionsError = Map<String, Failure>.from(state.auctionsError);

        auctionsError[type] = failure;
        loadingStats[type] = RequestState.error;

        emit(
          state.copyWith(
            auctionsRequestState: loadingStats,
            auctionsError: auctionsError,
          ),
        );

        log(failure.toString());
      },
      (freshModel) {
        loadingStats[type] = RequestState.loaded;
        cachedModel[type] = freshModel;
        emit(
          state.copyWith(
            auctionsRequestState: loadingStats,
            auctionsModel: cachedModel,
          ),
        );
      },
    );
  }

  Future<void> refreshAuctionsForTab() async {
    await getAuctions(refresh: true);
  }

  searchAuctionOrigins(String? query) {
    emit(state.copyWith(searchState: RequestState.loading));
    if (query == null || query.isEmpty && auctionData?.auctionOrigins != null) {
      originList = auctionData!.auctionOrigins!;
      emit(state.copyWith(searchState: RequestState.loaded));

      return;
    }
    originList =
        auctionData!.auctionOrigins
            ?.where(
              (origin) =>
                  origin.title != null &&
                  origin.title!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList() ??
        [];
    emit(state.copyWith(searchState: RequestState.loaded));
  }

  void changeShareAs(String shareAs) {
    emit(state.copyWith(shareAs: shareAs));
  }

  void auctionEnrollment() async {
    emit(state.copyWith(auctionEnrollmentRequestState: RequestState.loading));
    AuctionEnrollmentParams params = AuctionEnrollmentParams(
      auction: auctionId,
      auctionOrigin: originId!,
      shareAs: state.shareAs,
      type: type,
      agency: agencyId,
    );

    final result = await _homeRepository.auctionEnrollment(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            auctionEnrollmentRequestState: RequestState.error,
            auctionEnrollmentError: failure,
          ),
        );
        log(failure.toString());
      },
      (right) {
        auctionOrigin!.isEnrolled = true;
        int index =
            auctionData!.auctionOrigins?.indexWhere(
              (element) => element.id == auctionOrigin!.id,
            ) ??
            -1;
        auctionData!.auctionOrigins?[index].isEnrolled == true;
        emit(
          state.copyWith(
            auctionEnrollmentRequestState: RequestState.loaded,
            auctionEnrollmentMsg: right,
          ),
        );
        getAuctionBoard().then((val) {
          addNewBidValue();
        });
      },
    );
  }

  void deleteAuctionEnrollment() async {
    emit(
      state.copyWith(deleteAuctionEnrollmentRequestState: RequestState.loading),
    );
    GeneralAuctionParams params = GeneralAuctionParams(
      auctionId: auctionId,
      originId: originId,
      amount: amount,
      limit: limit,
    );

    final result = await _homeRepository.deleteAuctionEnrollment(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            deleteAuctionEnrollmentRequestState: RequestState.error,
            deleteAuctionEnrollmentError: failure,
          ),
        );
        log(failure.toString());
      },
      (right) {
        auctionOrigin!.isEnrolled = false;
        int index =
            auctionData!.auctionOrigins?.indexWhere(
              (element) => element.id == auctionOrigin!.id,
            ) ??
            -1;
        auctionData!.auctionOrigins?[index].isEnrolled == false;
        emit(
          state.copyWith(
            deleteAuctionEnrollmentRequestState: RequestState.loaded,
            deleteAuctionEnrollmentMsg: right,
          ),
        );

        getAuctionBoard();
      },
    );
  }

  Future<void> getAuctionBoard() async {
    emit(state.copyWith(getAuctionBoardRequestState: RequestState.loading));
    GeneralAuctionParams params = GeneralAuctionParams(
      auctionId: auctionId,
      originId: originId,
      amount: amount,
      limit: limit,
    );

    final result = await _homeRepository.getAuctionBoard(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getAuctionBoardRequestState: RequestState.error,
            getAuctionBoardError: failure,
          ),
        );
        log(failure.toString());
      },
      (right) async {
        boardAuctionData = right.data;
        emit(
          state.copyWith(
            topBid: boardAuctionData.isNotEmpty
                ? boardAuctionData.first.bidAmount
                : 0,
            getAuctionBoardRequestState: RequestState.loaded,
            getAuctionBoardModel: right,
          ),
        );

        await auctionBoardSocket.listenEvents();
        newBider();
      },
    );
  }

  void newBider() async {
    auctionBoardSocket.newBidersController.listen((biders) {
      print('Received biders: ${biders.data}');
      print('Before updating, boardAuctionData: $boardAuctionData');

      if (biders.data.isNotEmpty) {
        boardAuctionData.clear();
        boardAuctionData.addAll(biders.data);
        print('After updating, boardAuctionData: $boardAuctionData');

        if (!isClosed)
          emit(
            state.copyWith(
              topBid: boardAuctionData.isNotEmpty
                  ? boardAuctionData.first.bidAmount
                  : 0,
              getAuctionBoardRequestState: RequestState.loaded,
              getAuctionBoardModel: biders,
            ),
          );
      } else {
        print('Received biders is empty');
      }
    });
  }

  void addAuctionBid() async {
    emit(state.copyWith(addAuctionBidRequestState: RequestState.loading));
    dynamic amount = await calculateBidAmount();
    GeneralAuctionParams params = GeneralAuctionParams(
      auctionId: auctionData!.id,
      originId: auctionOrigin!.id,
      amount: amount,
      limit: limit,
    );

    final result = await _homeRepository.addAuctionBid(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            addAuctionBidRequestState: RequestState.error,
            addAuctionBidError: failure,
          ),
        );
        log(failure.toString());
      },
      (right) async {
        emit(
          state.copyWith(
            addAuctionBidRequestState: RequestState.loaded,
            addAuctionBidMsg: right,
          ),
        );
        await getAuctionBoard();
      },
    );
    limit = 6;
  }

  Future<dynamic> calculateBidAmount() async {
    String userId = serviceLocator<IAppLocalStorage>().getValue(
      AppStrings.userId,
    );
    print('userId $userId');

    limit = null;
    await getAuctionBoard();
    bool isUserInList = boardAuctionData.any((bid) => bid.user.id == userId);

    if (boardAuctionData.isEmpty) {
      dynamic amount = state.total;
      return amount;
    } else if (!isUserInList) {
      dynamic amount =
          (boardAuctionData.first.bidAmount - auctionOrigin!.openingPrice) +
          garlicDifferencetotalAmount;
      return amount;
    } else {
      BiderAuctionData userBid = boardAuctionData.firstWhere(
        (bid) => bid.user.id == userId,
      );
      print(
        'boardAuctionData.first.bidAmount${boardAuctionData.first.bidAmount} ',
      );
      print('userBid.bidAmount${userBid.bidAmount} ');
      print('garlicDifferencetotalAmount${garlicDifferencetotalAmount} ');
      print(
        'boardAuctionData.first.bidAmount${boardAuctionData.first.bidAmount} ',
      );
      dynamic amount =
          ((boardAuctionData.first.bidAmount - userBid.bidAmount) +
          garlicDifferencetotalAmount);

      return amount;
    }
  }

  Future<void> privacyPolicy() async {
    await getPolicy(AppStrings.policyPrivacy, refresh: true);
  }

  Future<void> getPolicy(String policyKey, {bool refresh = false}) async {
    final cachedModel = Map<String, PrivacyModel>.from(state.policiesModel);
    final loadingStats = Map<String, RequestState>.from(
      state.policiesRequestState,
    );
    final errors = Map<String, Failure>.from(state.policiesError);

    if (cachedModel[policyKey] != null && !refresh) {
      return;
    }

    loadingStats[policyKey] = RequestState.loading;
    emit(state.copyWith(policiesRequestState: loadingStats));

    final result = await _homeRepository.getPolicy(
      _policyEndpoint(policyKey),
    );

    result.fold(
      (failure) {
        errors[policyKey] = failure;
        loadingStats[policyKey] = RequestState.error;
        emit(
          state.copyWith(
            policiesRequestState: loadingStats,
            policiesError: errors,
          ),
        );
        log(failure.toString());
      },
      (model) {
        loadingStats[policyKey] = RequestState.loaded;
        cachedModel[policyKey] = model;
        emit(
          state.copyWith(
            policiesRequestState: loadingStats,
            policiesModel: cachedModel,
          ),
        );
      },
    );
  }

  String _policyEndpoint(String policyKey) {
    switch (policyKey) {
      case AppStrings.policyPrivacy:
        return EndPoint.privacyPolicy;
      case AppStrings.policyRefund:
        return EndPoint.refundPolicy;
      case AppStrings.policyIntellectual:
        return EndPoint.intellectualPropertyPolicy;
      default:
        return EndPoint.privacyPolicy;
    }
  }

  Future<void> getSettings  () async {
    emit(state.copyWith(getSettingRequestState: RequestState.loading));

    final result = await _homeRepository.getSettings();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getSettingRequestState: RequestState.error,
            getSettingError: failure,
          ),
        );
        log(failure.toString());
      },
      (right) {
        settingsModel = right;
        emit(
          state.copyWith(
            getSettingRequestState: RequestState.loaded,
            getSettingModel: right,
          ),
        );
      },
    );
  }

  Future<void> auctionBrochure(BuildContext context, String link) async {
    emit(state.copyWith(auctionBrochureRequestState: RequestState.loading));

    final result = await downloadFile(link, context);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            auctionBrochureRequestState: RequestState.error,
            auctionBrochureError: failure,
          ),
        );
        log(failure.message.toString());
      },
      (right) {
        emit(
          state.copyWith(
            auctionBrochureRequestState: RequestState.loaded,
            auctionBrochureMsg: right,
          ),
        );
      },
    );
  }

  void addWalletBalance() async {
    if (!addBalanceKey.currentState!.validate()) return;

    emit(state.copyWith(addWalletBalanceRequestState: RequestState.loading));

    final result = await _homeRepository.addWalletBalance(
      parseFormattedNumber(balanceController.text.trim()),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            addWalletBalanceRequestState: RequestState.error,
            addWalletBalanceError: failure,
          ),
        );
        log(failure.toString());
      },
      (right) async {
        emit(
          state.copyWith(
            addWalletBalanceRequestState: RequestState.loaded,
            addWalletBalanceMsg: right,
          ),
        );
      },
    );
  }

  void updatePropertyPrice(dynamic price) {
    // Calculations
    double transactionFee = price * 0.05;
    double commission = price * 0.025;
    double commissionTax = commission * 0.25;
    double total = price + transactionFee + commission + commissionTax;
    if (boardAuctionData.isNotEmpty) {
      garlicDifferencetotalAmount =
          state.topBid - boardAuctionData.first.bidAmount;
    }
    // Emit new state
    emit(
      state.copyWith(
        propertyPrice: price,
        transactionFee: transactionFee,
        commission: commission,
        commissionTax: commissionTax,
        total: total,
      ),
    );
  }

  void increaseBid() {
    double newBid = state.topBid + (auctionOrigin?.garlicDifference ?? 0);
    emit(state.copyWith(topBid: newBid));
    updatePropertyPrice(newBid);
  }

  void decreaseBid() {
    double newBid = state.topBid - (auctionOrigin?.garlicDifference ?? 0);
    if (newBid >
        (boardAuctionData.isEmpty
            ? auctionOrigin!.openingPrice
            : boardAuctionData.first.bidAmount)) {
      emit(state.copyWith(topBid: newBid));

      updatePropertyPrice(newBid);
    }
  }

  addNewBidValue() {
    emit(
      state.copyWith(
        topBid: boardAuctionData.isEmpty
            ? double.tryParse(auctionOrigin!.openingPrice.toString())
            : double.tryParse(
                (boardAuctionData.first.bidAmount +
                        auctionOrigin!.garlicDifference)
                    .toString(),
              ),
      ),
    );
    updatePropertyPrice(
      boardAuctionData.isEmpty
          ? double.tryParse(auctionOrigin!.openingPrice.toString())
          : double.tryParse(
              (boardAuctionData.first.bidAmount +
                      auctionOrigin!.garlicDifference)
                  .toString(),
            ),
    );
  }

  Future<Either<Failure, String>> addFavorite(String id) async {
    return await _homeRepository.addFavorite(
      GeneralAuctionParams(auctionId: id),
    );
  }

  Future<Either<Failure, String>> deleteAuctionFavorite(String id) async {
    return await _homeRepository.deleteAuctionFavorite(id);
  }

  Future<void> toggleFavoriteAuction(String id, bool isAdd) async {
    // Create a new map to ensure immutability
    final data = Map<String, AuctionsModel>.from(state.auctionsModel);

    AuctionData? originalItem; // Store the original item
    String? originalKey; // Store the original key

    // Update the data map
    data.forEach((key, value) {
      final updatedList = List<AuctionData>.from(
        value.data,
      ); // Create a new list
      for (int index = 0; index < updatedList.length; index++) {
        var item = updatedList[index];
        if (item.id == id) {
          if (originalItem == null) {
            originalItem = item; // Save the original item
            originalKey = key; // Save the original key
          }
          if (key == AppConstant.favorite && !isAdd) {
            updatedList.removeAt(index);
          } else {
            updatedList[index] = item.copyWith(isFavorite: isAdd);
          }
        }
      }
      data[key] = value.copyWith(data: updatedList); // Update the model
    });

    // Emit the loading state
    emit(
      state.copyWith(
        favoriteRequestState: RequestState.loading,
        auctionsModel: data,
      ),
    );

    // Perform the API call
    final result = await (isAdd ? addFavorite(id) : deleteAuctionFavorite(id));
    result.fold(
      (failure) {
        // Revert changes on failure
        if (originalItem != null && originalKey != null) {
          final revertedData = Map<String, AuctionsModel>.from(
            state.auctionsModel,
          );
          final revertedList = List<AuctionData>.from(
            revertedData[originalKey]!.data,
          );

          if (isAdd) {
            // Restore the item to its original state
            revertedList.add(originalItem!);
          } else {
            // Restore the item's favorite state
            final index = revertedList.indexWhere((item) => item.id == id);
            if (index != -1) {
              revertedList[index] = originalItem!;
            }
          }

          revertedData[originalKey!] = revertedData[originalKey]!.copyWith(
            data: revertedList,
          );

          // Emit the reverted state
          emit(
            state.copyWith(
              favoriteRequestState: RequestState.error,
              auctionsModel: revertedData,
            ),
          );
        }
      },
      (right) {
        // Emit the loaded state on success
        emit(state.copyWith(favoriteRequestState: RequestState.loaded));
      },
    );
  }
}
