import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationStreamProvider = StreamProvider<Position>((ref) async* {
  final locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  yield* Geolocator.getPositionStream(locationSettings: locationSettings);
});