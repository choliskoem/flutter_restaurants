import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dicoding_restaurant/core/extension/notification_helper.dart';
import 'package:flutter_dicoding_restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:http/http.dart';


import '../../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');

    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await RestaurantRemoteDatasource(Client()).topHeadlines();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
