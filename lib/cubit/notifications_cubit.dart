import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/cubit/notifications_states.dart';
import 'package:gatehub/models/notifications_model.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class NotificationCubit extends Cubit<NotificationState> {
   ApiConsumer api;
  NotificationCubit(this.api) : super(NotificationInitial(unreadNotifications: 0));
  final _firebaseMessaging = FirebaseMessaging.instance;
   final List<Map<String, String>> _notifications = [];
  int _unreadNotifications = 0;
  Future<void>initNotifications()async{
  await _firebaseMessaging.requestPermission();
    String?token=await _firebaseMessaging.getToken();
    print("Token :${token}");

  //     Future <void>saveNotificatinToFireStore(String title, String body)async{
  //   await FirebaseFirestore.instance.collection('notifications').add({
  //      'title': title,
  //      'body': body,
  //      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
  //   });
  // }
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
     final title = message.notification?.title ?? 'No Title';
     final body = message.notification?.body ?? 'No Title';
      sendNotification(title, body);
    //  saveNotificatinToFireStore(title, body);
  });
  }

  void sendNotification(String title, String message) {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final newNotification = {
      "title": title,
      "message": message,
      "date": formattedDate
    };
    _notifications.insert(0, newNotification); 
    _unreadNotifications++; 
    emit(NotificationUpdated(List.from(_notifications), _unreadNotifications));
  }
   

  void readNotifications() {
    _unreadNotifications = 0;
    emit(NotificationUpdated(List.from(_notifications), _unreadNotifications));
  }

 getNotifications()async{
   emit(NotificationsLoading());
  try {
  final response = await api.get(
    EndPoints.getNotifications
  );
      List<NotificationsModel> notificationsList = List<NotificationsModel>.from(
      response.map((notification) => NotificationsModel.fromJson(notification))
    );
     final firebaseList = _notifications.map((notif) => NotificationsModel(
      title: notif['title'] ?? '',
      body: notif['message'] ?? '',
      date: notif['date'] ?? '', 
      isRead: true
    )).toList();

    final mergedList = [...firebaseList, ...notificationsList];
    emit(GetNotificationsSuccess(mergedList));
} on ServerException catch (e) {
   emit(GetNotificationsFailure(errorMessage: e.errorModel.errorMessage));
}
 }
}Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final title = message.notification?.title ?? 'No Title';
  final body = message.notification?.body ?? 'No Body';
  
  getIt<NotificationCubit>().sendNotification(title, body);
}




// Future<void> getNotificationsFromFirestore() async {
//   emit(NotificationsLoading());
//   try {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('notifications') 
//         .get();

//     print("Documents: ${snapshot.docs.length}");

//     final notifications = snapshot.docs.map((doc) => NotificationsModel(
//       title: doc['title'] ?? '',
//       body: doc['body'] ?? '',
//       date: doc['date'] ?? '',
//       isRead: false,
//     )).toList();

//     emit(GetNotificationsSuccess(notifications));
//   } catch (e) {
//     print("ERROR: $e");
//     emit(GetNotificationsFailure(errorMessage: e.toString()));
//   }
// }

 


