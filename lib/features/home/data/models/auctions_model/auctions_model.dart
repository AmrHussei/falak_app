import 'package:equatable/equatable.dart';

class AuctionsModel extends Equatable {
  final List<AuctionData> data;

  AuctionsModel({required this.data});

  factory AuctionsModel.fromJson(Map<String?, dynamic> json) {
    return AuctionsModel(
      data: List<AuctionData>.from(
        json['data'].map((x) => AuctionData.fromJson(x)),
      ),
    );
  }

  AuctionsModel copyWith({List<AuctionData>? data}) {
    return AuctionsModel(
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [data];
}

class AuctionData extends Equatable {
  final String id;
  final bool? agencyBid;
  final Location? location;
  final String? startDate;
  final String? endDate;
  final int? numberOfDays;
  final String? status;
  final String? type;
  final String? auctionApprovalNumber;
  final String? title;
  final String? cover;
  final Provider? provider;
  final List<Logo>? logos;
  final String? auctionBrochure;
  final bool? isFavorite;
  final List<AuctionOrigin>? auctionOrigins;
  final TimerAuction? timer;

  const AuctionData({
    required this.id,
     this.agencyBid,
    this.location,
    this.startDate,
    this.endDate,
    this.numberOfDays,
    this.status,
    this.type,
    this.auctionApprovalNumber,
    this.title,
    this.cover,
    this.provider,
    this.logos,
    this.auctionBrochure,
    this.isFavorite,
    this.auctionOrigins,
    this.timer,
  });

  factory AuctionData.fromJson(Map<String?, dynamic> json) {
    return AuctionData(
      id: json['_id'],
      agencyBid: json['agencyBid'],
      location: Location.fromJson(json['location']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      numberOfDays: json['numberOfDays'],
      status: json['status'],
      type: json['type'],
      auctionApprovalNumber: json['auctionApprovalNumber'],
      title: json['title'],
      cover: json['cover'],
      provider: Provider.fromJson(json['provider']),
      logos: List<Logo>.from(json['logos'].map((x) => Logo.fromJson(x))),
      auctionBrochure: json['auctionBrochure'],
      isFavorite: json['isFavorite'] ?? true,
      auctionOrigins: List<AuctionOrigin>.from(
        json['auctionOrigins'].map((x) => AuctionOrigin.fromJson(x)),
      ),
      timer: json['timer'] == null
          ? null
          : TimerAuction.fromJson(json['timer']),
    );
  }

  AuctionData copyWith({bool? isFavorite}) => AuctionData(
    id: id,
    agencyBid: agencyBid,
    isFavorite: isFavorite ?? this.isFavorite,
    type: type,
    title: title,
    status: status,
    auctionApprovalNumber: auctionApprovalNumber,
    auctionBrochure: auctionBrochure,
    auctionOrigins: auctionOrigins,
    endDate: endDate,
    cover: cover,
    location: location,
    logos: logos,
    numberOfDays: numberOfDays,
    provider: provider,
    startDate: startDate,
    timer: timer,
  );

  @override
  List<Object?> get props => [id, title, status, cover,isFavorite,agencyBid];
}

class Location {
  final double longitude;
  final double latitude;
  final String? title;

  const Location({
    required this.longitude,
    required this.latitude,
    required this.title,
  });

  factory Location.fromJson(Map<String?, dynamic> json) {
    return Location(
      longitude: json['longitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'longitude': longitude, 'latitude': latitude, 'title': title};
  }
}

class Provider {
  final String? companyName;

  final String? companyProfileImage;
  final String? valAuctionsLicenseNumber;
  final CompanyPhoneNumber? companyPhoneNumber;
  final CompanyPhoneNumber? auctionPhoneNumber;
  final String? companyEmail;

  Provider({
    this.companyName,
    this.companyProfileImage,
    required this.valAuctionsLicenseNumber,
    this.companyPhoneNumber,
    this.auctionPhoneNumber,
    this.companyEmail,
  });

  factory Provider.fromJson(Map<String?, dynamic> json) {
    return Provider(
      companyName: json['companyName'],
      companyProfileImage: json['companyProfileImage'],
      valAuctionsLicenseNumber: json['valAuctionsLicenseNumber'],
      companyPhoneNumber: json['companyPhoneNumber'] != null
          ? CompanyPhoneNumber.fromJson(json['companyPhoneNumber'])
          : null,
      auctionPhoneNumber: json['auctionPhoneNumber'] != null
          ? CompanyPhoneNumber.fromJson(json['auctionPhoneNumber'])
          : null,
      companyEmail: json['companyEmail'],
    );
  }
}

class CompanyPhoneNumber {
  final String? key;
  final String? number;

  CompanyPhoneNumber({required this.key, required this.number});

  factory CompanyPhoneNumber.fromJson(Map<String?, dynamic> json) {
    return CompanyPhoneNumber(key: json['key'], number: json['number']);
  }
}

class Logo {
  final String id;
  final String? logo;
  final bool? active;

  Logo({required this.id, required this.logo, required this.active});

  factory Logo.fromJson(Map<String?, dynamic> json) {
    return Logo(id: json['_id'], logo: json['logo'], active: json['active']);
  }
}

class AuctionOrigin {
  String id;
  String? title;
  String? description;
  List<String> attachment;
  dynamic openingPrice;
  dynamic entryDeposit;
  dynamic garlicDifference;
  dynamic highestBid;
  List<Detail> details;
  bool? isFavorite;
  bool? isEnrolled;
  final Location location;

  AuctionOrigin({
    required this.id,
    required this.title,
    required this.description,
    required this.attachment,
    required this.openingPrice,
    required this.entryDeposit,
    required this.garlicDifference,
    required this.highestBid,
    required this.details,
    required this.isFavorite,
    required this.isEnrolled,
    required this.location,
  });

  // From JSON
  factory AuctionOrigin.fromJson(Map<String?, dynamic> json) {
    return AuctionOrigin(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      attachment: List<String>.from(json['attachment']),
      openingPrice: json['openingPrice'],
      entryDeposit: json['entryDeposit'],
      garlicDifference: json['garlicDifference'],
      highestBid: json['highestBid'],
      details: (json['details'] as List)
          .map((item) => Detail.fromJson(item))
          .toList(),
      isFavorite: json['isFavorite'] ?? true,
      isEnrolled: json['isEnrolled'],
      location: Location.fromJson(json['location']),
    );
  }

}

class Detail {
  String? title;
  List<AuctionDetail> auctionDetails;

  Detail({required this.title, required this.auctionDetails});

  // From JSON
  factory Detail.fromJson(Map<String?, dynamic> json) {
    return Detail(
      title: json['title'],
      auctionDetails: (json['auctionDetails'] as List)
          .map((item) => AuctionDetail.fromJson(item))
          .toList(),
    );
  }

  // To JSON
  Map<String?, dynamic> toJson() {
    return {
      'title': title,
      'auctionDetails': auctionDetails.map((item) => item.toJson()).toList(),
    };
  }
}

class AuctionDetail {
  String? title;
  String? description;

  AuctionDetail({required this.title, required this.description});

  // From JSON
  factory AuctionDetail.fromJson(Map<String?, dynamic> json) {
    return AuctionDetail(
      title: json['title'],
      description: json['description'],
    );
  }

  // To JSON
  Map<String?, dynamic> toJson() {
    return {'title': title, 'description': description};
  }
}


class TimerAuction {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  TimerAuction({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory TimerAuction.fromJson(Map<String?, dynamic> json) {
    return TimerAuction(
      days: json['days'],
      hours: json['hours'],
      minutes: json['minutes'],
      seconds: json['seconds'],
    );
  }
}
