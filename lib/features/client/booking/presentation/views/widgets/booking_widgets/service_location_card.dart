import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:salahly/core/theme/app_theme.dart';

class ServiceLocationCard extends StatelessWidget {
  final LatLng currentLatLng;
  final String addressTitle;
  final String addressDetails;
  final VoidCallback onTap;

  const ServiceLocationCard({
    super.key,
    required this.currentLatLng,
    required this.addressTitle,
    required this.addressDetails,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'service_location_title'.tr(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppTheme.slate500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: AbsorbPointer(
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: currentLatLng,
                        initialZoom: 15.0,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        TileLayer(
                          // ⚡ استخدام سيرفر CartoDB لنفس الكارت الصغير لتجنب الـ Throttling
                          urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png',
                          subdomains: const ['a', 'b', 'c', 'd'],
                          userAgentPackageName: 'com.salahly.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: currentLatLng,
                              child: const Icon(
                                Icons.location_on,
                                color: AppTheme.accentAmber,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.accentAmber, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addressTitle,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(
                              addressDetails,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: AppTheme.slate500, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: onTap,
                        child: Text(
                          'edit'.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}