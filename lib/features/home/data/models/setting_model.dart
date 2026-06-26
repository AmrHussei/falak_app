class SettingsModel {
  final String message;
  final SettingsData data;

  SettingsModel({
    required this.message,
    required this.data,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      message: json['message'] ?? '',
      data: SettingsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class SettingsData {
  final AuctionPhoneNumber auctionPhoneNumber;
  final LocalizedText mainTitle;
  final LocalizedText mainDescription;
  final String id;
  final int v;
  final int authorityAuctionExtraTime;
  final String companyLogo;
  final DateTime createdAt;
  final int privateAuctionExtraTime;
  final String profileImage;
  final String providerCoverImage;
  final String providerLogo;
  final DateTime updatedAt;
  final String valAuctionsLicenseNumber;
  final int withdrawalFee;
  final bool acceptProviderAuctionSubmissions;
  final bool acceptProviderRequests;

  SettingsData({
    required this.auctionPhoneNumber,
    required this.mainTitle,
    required this.mainDescription,
    required this.id,
    required this.v,
    required this.authorityAuctionExtraTime,
    required this.companyLogo,
    required this.createdAt,
    required this.privateAuctionExtraTime,
    required this.profileImage,
    required this.providerCoverImage,
    required this.providerLogo,
    required this.updatedAt,
    required this.valAuctionsLicenseNumber,
    required this.withdrawalFee,
    required this.acceptProviderAuctionSubmissions,
    required this.acceptProviderRequests,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      auctionPhoneNumber:
          AuctionPhoneNumber.fromJson(json['auctionPhoneNumber'] ?? {}),
      mainTitle: LocalizedText.fromJson(json['mainTitle'] ?? {}),
      mainDescription:
          LocalizedText.fromJson(json['mainDescription'] ?? {}),
      id: json['_id'] ?? '',
      v: json['__v'] ?? 0,
      authorityAuctionExtraTime:
          json['authorityAuctionExtraTime'] ?? 0,
      companyLogo: json['companyLogo'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      privateAuctionExtraTime:
          json['privateAuctionExtraTime'] ?? 0,
      profileImage: json['profileImage'] ?? '',
      providerCoverImage: json['providerCoverImage'] ?? '',
      providerLogo: json['providerLogo'] ?? '',
      updatedAt: DateTime.parse(json['updatedAt']),
      valAuctionsLicenseNumber:
          json['valAuctionsLicenseNumber'] ?? '',
      withdrawalFee: json['withdrawalFee'] ?? 0,
      acceptProviderAuctionSubmissions:
          json['acceptProviderAuctionSubmissions'] ?? false,
      acceptProviderRequests:
          json['acceptProviderRequests'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auctionPhoneNumber': auctionPhoneNumber.toJson(),
      'mainTitle': mainTitle.toJson(),
      'mainDescription': mainDescription.toJson(),
      '_id': id,
      '__v': v,
      'authorityAuctionExtraTime': authorityAuctionExtraTime,
      'companyLogo': companyLogo,
      'createdAt': createdAt.toIso8601String(),
      'privateAuctionExtraTime': privateAuctionExtraTime,
      'profileImage': profileImage,
      'providerCoverImage': providerCoverImage,
      'providerLogo': providerLogo,
      'updatedAt': updatedAt.toIso8601String(),
      'valAuctionsLicenseNumber': valAuctionsLicenseNumber,
      'withdrawalFee': withdrawalFee,
      'acceptProviderAuctionSubmissions':
          acceptProviderAuctionSubmissions,
      'acceptProviderRequests': acceptProviderRequests,
    };
  }
}

class AuctionPhoneNumber {
  final String key;
  final String number;

  AuctionPhoneNumber({
    required this.key,
    required this.number,
  });

  factory AuctionPhoneNumber.fromJson(Map<String, dynamic> json) {
    return AuctionPhoneNumber(
      key: json['key'] ?? '',
      number: json['number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'number': number,
    };
  }
}

class LocalizedText {
  final String? ar;
  final String? en;

  LocalizedText({
    this.ar,
    this.en,
  });

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      ar: json['ar'],
      en: json['en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}