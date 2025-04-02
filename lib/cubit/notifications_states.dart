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