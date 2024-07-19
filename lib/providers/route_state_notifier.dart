import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteState {
  final bool isRouteStarted;

  RouteState({required this.isRouteStarted});
}

class RouteStateNotifier extends StateNotifier<RouteState> {
  RouteStateNotifier() : super(RouteState(isRouteStarted: false));

  void startRoute() {
    state = RouteState(isRouteStarted: true);
  }

  void endRoute() {
    state = RouteState(isRouteStarted: false);
  }
}

final routeStateProvider =
    StateNotifierProvider<RouteStateNotifier, RouteState>((ref) {
  return RouteStateNotifier();
});