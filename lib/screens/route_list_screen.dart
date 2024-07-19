import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurye_app/providers/route_provider.dart';
import 'package:kurye_app/routes/routes.gr.dart';
import 'package:latlong2/latlong.dart';

class RouteListScreen extends ConsumerWidget {
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum hizmetlerinin etkin olup olmadığını kontrol et
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Konum hizmetleri etkin değilse kullanıcıya uyarı ver
      await Geolocator.openLocationSettings();
      return Future.error('Konum hizmetleri etkin değil.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Konum izni reddedildi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Konum izni kalıcı olarak reddedildi.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(routesProvider);
    final theme = Theme.of(context); // Temayı al

    return Scaffold(
      appBar: AppBar(
        title: Text('Gelen Konumlar'),
        backgroundColor: theme.primaryColor, // AppTheme rengi
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Oval köşeler
              ),
              elevation: 4,
              color: theme.cardColor, // Kart rengi
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () async {
                  // "Rota oluşturuluyor" mesajını ve progress bar'ı göster
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Rota oluşturuluyor...'),
                          ],
                        ),
                      );
                    },
                  );

                  // Konumu al
                  Position currentPosition = await _getCurrentLocation();
                  LatLng currentLatLng = LatLng(
                      currentPosition.latitude, currentPosition.longitude);

                  // Dialog'u kapat
                  Navigator.of(context).pop();

                  // Rota detay ekranına yönlendir
                  context.router.push(RouteDetailRoute(
                    routeId: route.id,
                    currentLocation: currentLatLng,
                  ));
                },
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(
                    route.name,
                    style: TextStyle(
                      color: theme.primaryColor, // Başlık rengi
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Konum Detayları ${route.name}',
                    style: TextStyle(
                      color: theme.primaryColorDark, // Alt başlık rengi
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
