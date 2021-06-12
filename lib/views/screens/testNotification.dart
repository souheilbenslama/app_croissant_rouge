import 'package:app_croissant_rouge/services/notificationManager.dart';
import 'package:flutter/material.dart';

class TestNotification extends StatefulWidget {
  @override
  _TestNotificationState createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {
  void initState() {
    super.initState();
    notificationManager.setOnNotificationReceive(onNotificationReceive);
    notificationManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    print('Notification Received : ${notification.id}');
  }

  onNotificationClick(String payload) {
    print('payload $payload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification TEST'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Send Notification'),
          onPressed: () async {
            //await notificationManager.showNotification();
          },
        ),
      ),
    );
  }
}
