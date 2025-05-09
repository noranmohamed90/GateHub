import 'package:gatehub/services/end_points.dart';

class NotificationsModel {
  final String title;
  final String body;
  final String date;
  final bool isRead;

  NotificationsModel({required this.title,
   required this.body,
    required this.date,
   required this.isRead});

factory NotificationsModel.fromJson(Map<String,dynamic>jsonData){
  
  return NotificationsModel(
    title: jsonData[ApiKey.title] ?? '',
     body: jsonData[ApiKey.body]?? '',
     date: jsonData[ApiKey.createdAt]?? '',
     isRead: jsonData[ApiKey.isRead]?? false,
     );
   

}
}