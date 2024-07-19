import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurye_app/models/route.dart';

final routesProvider = Provider<List<Route>>((ref) {
  return [
    Route(id: 1, name: '1. Rota', customers: [
      Customer(
          id: 1, name: 'Ahmet Ç 1', latitude: 41.368319, longitude: 36.228711),
      Customer(
          id: 2, name: 'Feyza B 2', latitude: 37.8044, longitude: -122.2711),
    ]),
    Route(id: 2, name: '2. Rota', customers: [
      Customer(id: 3, name: 'Sefa 3', latitude: 34.0522, longitude: -118.2437),
      Customer(id: 4, name: 'Leyla 4', latitude: 36.1699, longitude: -115.1398),
    ]),
  ];
});
