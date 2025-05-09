import 'package:gatehub/models/notifications_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {
  final int unreadNotifications;

  NotificationInitial({this.unreadNotifications = 0});
}

class NotificationUpdated extends NotificationState {
  final List<Map<String, String>> notifications;
  final int unreadNotifications;

  NotificationUpdated(this.notifications, this.unreadNotifications);
}
class NotificationsLoading extends NotificationState{}
class GetNotificationsSuccess extends NotificationState {
  final List<NotificationsModel> notifications;
  GetNotificationsSuccess(this.notifications);
}
class GetNotificationsFailure extends NotificationState {
  final String errorMessage;
  GetNotificationsFailure({required this.errorMessage});
}