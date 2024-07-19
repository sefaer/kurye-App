// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:latlong2/latlong.dart' as _i5;

import '../screens/route_detail_screen.dart' as _i2;
import '../screens/route_list_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    RouteListRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.RouteListScreen(),
      );
    },
    RouteDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RouteDetailRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.RouteDetailScreen(
          routeId: args.routeId,
          currentLocation: args.currentLocation,
        ),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          RouteListRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          RouteDetailRoute.name,
          path: '/route-detail-screen',
        ),
      ];
}

/// generated route for
/// [_i1.RouteListScreen]
class RouteListRoute extends _i3.PageRouteInfo<void> {
  const RouteListRoute()
      : super(
          RouteListRoute.name,
          path: '/',
        );

  static const String name = 'RouteListRoute';
}

/// generated route for
/// [_i2.RouteDetailScreen]
class RouteDetailRoute extends _i3.PageRouteInfo<RouteDetailRouteArgs> {
  RouteDetailRoute({
    required int routeId,
    required _i5.LatLng currentLocation,
  }) : super(
          RouteDetailRoute.name,
          path: '/route-detail-screen',
          args: RouteDetailRouteArgs(
            routeId: routeId,
            currentLocation: currentLocation,
          ),
        );

  static const String name = 'RouteDetailRoute';
}

class RouteDetailRouteArgs {
  const RouteDetailRouteArgs({
    required this.routeId,
    required this.currentLocation,
  });

  final int routeId;

  final _i5.LatLng currentLocation;

  @override
  String toString() {
    return 'RouteDetailRouteArgs{routeId: $routeId, currentLocation: $currentLocation}';
  }
}
