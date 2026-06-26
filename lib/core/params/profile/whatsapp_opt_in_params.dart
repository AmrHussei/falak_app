import 'package:equatable/equatable.dart';

class WhatsappOptInParams extends Equatable {
  final String optInText;

  const WhatsappOptInParams({
    this.optInText =
        'I agree to receive WhatsApp messages from Falak.',
  });

  @override
  List<Object?> get props => [optInText];

  Map<String, dynamic> toMap() {
    return {'optInText': optInText};
  }
}
