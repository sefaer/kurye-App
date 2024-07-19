import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:kurye_app/routes/routes.gr.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurye_app/styles/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // OneSignal initialization
  // OneSignal.shared.setAppId('onesignalId');

  await Permission.location.request();

  runApp(ProviderScope(child: DriverApp()));
}

class DriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      theme: appTheme,
    );
  }
}
