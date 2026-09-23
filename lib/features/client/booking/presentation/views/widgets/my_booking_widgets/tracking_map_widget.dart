import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/core/theme/app_theme.dart';

class TrackingMapWidget extends StatelessWidget {
  final MapController mapController;
  final LatLng clientLocation;
  final LatLng technicianLocation;

  const TrackingMapWidget({
    super.key,
    required this.mapController,
    required this.clientLocation,
    required this.technicianLocation,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: clientLocation,
        initialZoom: 14.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.salahly.app',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: [technicianLocation, clientLocation],
              strokeWidth: 4.0,
              color: AppTheme.primaryNavy,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            // علامة موقع العميل (منزل)
            Marker(
              point: clientLocation,
              width: 44,
              height: 44,
              child: const Icon(
                Icons.home_filled,
                color: Color(0xFFE11D48),
                size: 38,
              ),
            ),
            // علامة موقع الفني الحية
            Marker(
              point: technicianLocation,
              width: 50,
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.accentAmber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.handyman_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}