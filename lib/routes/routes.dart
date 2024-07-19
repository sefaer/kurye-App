import 'package:auto_route/auto_route.dart';
import 'package:kurye_app/screens/route_detail_screen.dart';
import 'package:kurye_app/screens/route_list_screen.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: RouteListScreen, initial: true),
    AutoRoute(page: RouteDetailScreen),
  ],
)
class $AppRouter {}