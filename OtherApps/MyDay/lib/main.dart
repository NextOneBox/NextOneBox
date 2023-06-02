import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myday/pages.dart';
import 'package:hive/hive.dart';
import 'main.dart';
export 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Directory docume = await getApplicationDocumentsDirectory();

  // Hive.init(docume.path);
  // await Hive.openBox('pages');

  await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            groupAlertBehavior: GroupAlertBehavior.Summary,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            defaultColor: Colors.deepPurple,
            channelShowBadge: false,
            ledColor: Colors.deepPurple)
      ],
      debug: false);
  runApp(MyApp());
}

getApplicationDocumentsDirectory() {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void Notify() async {
      Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
        if (receivedAction.actionType == ActionType.Default) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => VoiceScreen()),
          // );
        }
      }

      AwesomeNotifications()
          .setListeners(onActionReceivedMethod: onActionReceivedMethod);

      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1, // -1 is replaced by a random number
              channelKey: 'alerts',
              title: 'Get answer instantly',
              locked: true,
              displayOnForeground: true,
              displayOnBackground: true,
              body: "Use the power of AI to live ahead",
              autoDismissible: true,
              notificationLayout: NotificationLayout.Default,
              payload: {'notificationId': '1234567890'}),
          actionButtons: [
            // how to give icon to NotificationActionButton
            NotificationActionButton(
                color: Colors.red,
                key: 'Voice',
                label: 'Talk',
                actionType: ActionType.Default),

            // how to give icon in string in flutter
          ]);
      Notify();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Pages(),
    );
  }
}
