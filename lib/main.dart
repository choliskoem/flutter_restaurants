
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant/core/extension/notification_helper.dart';
import 'package:flutter_dicoding_restaurant/core/extension/schedule_provider.dart';
import 'package:flutter_dicoding_restaurant/core/extension/shared_preferences.dart';
import 'package:flutter_dicoding_restaurant/core/extension/shared_preferences_provider.dart';
import 'package:flutter_dicoding_restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:flutter_dicoding_restaurant/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_dicoding_restaurant/presentation/search/bloc/search/search_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/extension/background_service.dart';
import 'presentation/detail/bloc/bloc/detail_bloc.dart';
import 'presentation/listrest/bloc/list/list_bloc.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initIsolate();

  await AndroidAlarmManager.initialize();

  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SharedPrefProvider(
            sharedPrefHelper: SharedPrefHelper(
              sharedPreference: SharedPreferences.getInstance(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ListBloc(RestaurantRemoteDatasource(Client())),
        ),
        BlocProvider(
          create: (context) => DetailBloc(RestaurantRemoteDatasource(Client())),
        ),
        BlocProvider(
          create: (context) => SearchBloc(RestaurantRemoteDatasource(Client())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xffED5511),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffED5511),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xffED5511),
          ),
          useMaterial3: true,
        ),
        home: const DashboardPage(),
      ),
    );
  }
}
