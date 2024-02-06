import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_osmanli/notification/notification_service.dart';

class NotificationHandler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamSubscription<List<Map<String, dynamic>>> _streamSubscription;
  late DateTime now = DateTime.now();

  static final NotificationHandler _instance = NotificationHandler._internal();

  factory NotificationHandler() {
    return _instance;
  }

  NotificationHandler._internal() {
    startListening();
  }

  void handleNotifications(List<Map<String, dynamic>> notifications) {
    for (var notification in notifications) {
      DateTime notificationTime =
          DateTime.parse(notification['timestamp']).toLocal();

      if (notificationTime.isAfter(now)) {
        now = notificationTime;
        NotificationService.showNotification(
          notification['title'],
          notification['message'],
        );
        log('New Notification: ${notification['message']}');
      }
    }
  }

  void startListening() {
    _streamSubscription = getNotificationsStream().listen((notifications) {
      handleNotifications(notifications);
    });
  }

  void continueListening() {
    _streamSubscription.resume();
  }

  void stopListening() {
    _streamSubscription.pause();
  }

  Stream<List<Map<String, dynamic>>> getNotificationsStream() {
    return _firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> notifications = [];
      querySnapshot.docs.forEach((doc) {
        notifications.add({
          'timestamp': doc['timestamp'],
          'message': doc['message'],
          'title': doc['title'],
          'userId': doc['userId'],
        });
      });
      return notifications;
    });
  }
}
