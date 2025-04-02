import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/cubit/notifications_states.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial(unreadNotifications: 0));

  final List<Map<String, String>> _notifications = [];
  int _unreadNotifications = 0;

  void sendNotification(String title, String message) {
    final newNotification = {
      "title": title,
      "message": message,
      "date": DateTime.now().toIso8601String().split('T')[0],
    };
    _notifications.insert(0, newNotification); 
    _unreadNotifications++; 
    emit(NotificationUpdated(List.from(_notifications), _unreadNotifications));
  }

  void readNotifications() {
    _unreadNotifications = 0;
    emit(NotificationUpdated(List.from(_notifications), _unreadNotifications));
  }
}