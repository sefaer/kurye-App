import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:kurye_app/providers/route_provider.dart';
import 'package:kurye_app/providers/location_provider.dart'; // Konum sağlayıcıyı import et

class RouteDetailScreen extends ConsumerWidget {
  final int routeId;
  final LatLng currentLocation;

  RouteDetailScreen({
    required this.routeId,
    required this.currentLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationStream = ref.watch(locationStreamProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rota Detayları',
            style: TextStyle(color: theme.primaryColorDark)),
      ),
      body: locationStream.when(
        data: (position) {
          final newLocation = LatLng(position.latitude, position.longitude);
          final destinationLocation = _getDestinationLocation(ref, routeId);

          final distance = _calculateDistance(newLocation, destinationLocation);
          final duration = _formatDuration(_calculateDuration(distance));

          return Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: newLocation,
                    initialZoom: 12.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [newLocation, destinationLocation],
                          strokeWidth: 4.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: newLocation,
                          child: Icon(Icons.location_on,
                              color: Colors.red, size: 40),
                        ),
                        Marker(
                          point: destinationLocation,
                          child: Icon(Icons.location_on,
                              color: Colors.green, size: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Mesafe: ${distance.toStringAsFixed(2)} km\nTahmini Süre: $duration',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColorDark),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            double distance = _calculateDistance(
                                newLocation, destinationLocation);
                            double duration = _calculateDuration(distance);
                            String formattedDuration =
                                _formatDuration(duration);
                            _showAlertDialog(
                              context,
                              'Rota Başladı',
                              'Mesafe: ${distance.toStringAsFixed(2)} km\nTahmini Süre: $formattedDuration\nOrtalama 50km/h ile hesaplanmıştır.',
                            );
                          },
                          child: Text('Başla'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showAlertDialog(
                              context,
                              'Rota Tamamlandı',
                              'Rota başarıyla tamamlandı.',
                            );
                          },
                          child: Text('Bitir'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Konum bilgisi alınamadı')),
      ),
    );
  }

  LatLng _getDestinationLocation(WidgetRef ref, int routeId) {
    final routes = ref.read(routesProvider);
    final route = routes.firstWhere((route) => route.id == routeId);
    return LatLng(
        route.customers.first.latitude, route.customers.first.longitude);
  }

  double _calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
          start.latitude,
          start.longitude,
          end.latitude,
          end.longitude,
        ) /
        1000; // Metreden kilometreye çevir
  }

  double _calculateDuration(double distance) {
    const double averageSpeedKmh = 50.0; // Ortalama hız (km/s)
    return (distance / averageSpeedKmh) * 60; // Süreyi dakikaya çevir
  }

  String _formatDuration(double duration) {
    if (duration >= 60) {
      int hours = duration ~/ 60;
      int minutes = (duration % 60).toInt();
      return '$hours saat $minutes dakika';
    } else {
      return '${duration.toInt()} dakika';
    }
  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
