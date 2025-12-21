import 'package:equatable/equatable.dart';
import 'notification_model.dart';

class NotificationsResponseModel extends Equatable {
  final String? message;
  final NotificationsPagination pagination;
  final List<NotificationModel> data;

  const NotificationsResponseModel({
    this.message,
    required this.pagination,
    required this.data,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationsResponseModel(
      message: json['message'] as String?,
      pagination: NotificationsPagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
      data: NotificationModel.notificationListFromJson(
        json['data'] as List<dynamic>,
      ),
    );
  }

  @override
  List<Object?> get props => [message, pagination, data];
}

class NotificationsPagination extends Equatable {
  final int currentPage;
  final int resultCount;
  final int totalPages;

  const NotificationsPagination({
    required this.currentPage,
    required this.resultCount,
    required this.totalPages,
  });

  factory NotificationsPagination.fromJson(Map<String, dynamic> json) {
    return NotificationsPagination(
      currentPage: json['currentPage'] as int? ?? 1,
      resultCount: json['resultCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }

  bool get hasMorePages => currentPage < totalPages;

  @override
  List<Object?> get props => [currentPage, resultCount, totalPages];
}
