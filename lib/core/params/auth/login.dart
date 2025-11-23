import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String identityNumber;
  final String password;

  const LoginParams({
    required this.identityNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [identityNumber, password];
  // String get sanitizedPhoneNumber {
  //   if (identityNumber.startsWith('+966')) {
  //     return identityNumber.replaceFirst('+966', '');
  //   }
  //   if (identityNumber.startsWith('0')) {
  //     return identityNumber.replaceFirst('0', '');
  //   }
  //   return identityNumber;
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identityNumber': identityNumber,
      'password': password,
    };
  }
}
