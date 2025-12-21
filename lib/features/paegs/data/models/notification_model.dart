import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    this.id,
    this.sender,
    this.type,
    this.reference,
    this.status,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.message,
  });

  factory NotificationModel.fromJson(dynamic json) {
    return NotificationModel(
      id: json['_id'],
      type: json['type'],
      status: json['status'],
      readAt: json['readAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      title: json['title'],
      message: json['message'],
      reference: json['reference'] != null
          ? Reference.fromJson(json['reference'])
          : null,
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
    );
  }

  final Sender? sender;
  final Reference? reference;
  final String? id;
  final String? type;
  final String? status;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final String? message;

  NotificationModel copyWith({String? readAt}) {
    return NotificationModel(
      readAt: readAt ?? this.readAt,
      createdAt: createdAt,
      id: id,
      message: message,
      reference: reference,
      sender: sender,
      status: status,
      title: title,
      type: type,
      updatedAt: updatedAt,
    );
  }

  static List<NotificationModel> notificationListFromJson(List<dynamic> json) =>
      json.map((e) => NotificationModel.fromJson(e)).toList();

  @override
  List<Object?> get props => [
    id,
    reference,
    readAt,
    createdAt,
    message,
    sender,
    status,
    type,
    updatedAt,
    title,
  ];
}

class Reference {
  Reference({this.model, this.id});

  Reference.fromJson(dynamic json) {
    model = json['model'];
    id = json['id'];
  }

  dynamic model;
  dynamic id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model'] = model;
    map['id'] = id;
    return map;
  }
}

class Sender {
  Sender({this.profileImage});

  Sender.fromJson(dynamic json) {
    profileImage = json['profileImage'];
  }

  dynamic profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profileImage'] = profileImage;
    return map;
  }
}
