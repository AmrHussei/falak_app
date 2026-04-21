class SignUpModel {
  final String message;
  final AuthData data;

  SignUpModel({required this.message, required this.data});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json['message'],
      data: AuthData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data.toJson()};
  }
}

class AuthData {
  final String identityNumber;

  AuthData({required this.identityNumber});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(identityNumber: json['identityNumber']);
  }

  Map<String, dynamic> toJson() {
    return {'identityNumber': identityNumber};
  }
}
