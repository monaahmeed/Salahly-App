import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/core/utils/functions/location_helper.dart';

class PickLocationView extends StatefulWidget {
  final LatLng initialPosition;
  const PickLocationView({super.key, required this.initialPosition});

  @override
  State<PickLocationView> createState() => _PickLocationViewState();
}

class _PickLocationViewState extends State<PickLocationView> {
  late LatLng _pickedPosition;
  late final MapController _mapController;
  String _addressText = 'loading_address'.tr();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    _pickedPosition = widget.initialPosition;
    _mapController = MapController();
    
    
    _loadInitialAddress();
  }

  
  Future<void> _loadInitialAddress() async {
    final address = await _fetchAddressFromLatLng(_pickedPosition);
    if (mounted) {
      setState(() {
        _addressText = address;
      });
    }
  }

  
  Future<void> _moveToCurrentLocation() async {
    setState(() => _isLoading = true);

    final position = await LocationHelper.getCurrentLocation();

    if (position != null && mounted) {
      final currentLatLng = LatLng(position.latitude, position.longitude);
      _pickedPosition = currentLatLng;

      
      _mapController.move(currentLatLng, 16.0);

      
      final address = await _fetchAddressFromLatLng(currentLatLng);
      if (mounted) {
        setState(() {
          _addressText = address;
          _isLoading = false;
        });
      }
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  
  Future<String> _fetchAddressFromLatLng(LatLng pos) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      ).timeout(const Duration(seconds: 4));

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final subLocality = place.subLocality ?? place.street ?? '';
        final locality = place.locality ?? place.administrativeArea ?? '';

        return (subLocality.isNotEmpty || locality.isNotEmpty)
            ? '$subLocality, $locality'
            : 'custom_location_selected'.tr();
      }
    } catch (_) {}
    return 'custom_location_selected'.tr();
  }

  
  Future<void> _handleConfirmLocation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const Center(
        child: CircularProgressIndicator(color: AppTheme.accentAmber),
      ),
    );

    final finalAddress = await _fetchAddressFromLatLng(_pickedPosition);

    if (!mounted) return;

    Navigator.of(context, rootNavigator: true).pop(); 

    Navigator.of(context).pop({
      'latLng': _pickedPosition,
      'address': finalAddress,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pick_location_title'.tr())),
      body: Stack(
        children: [
         
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialPosition, 
              initialZoom: 16.0,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture && position.center != null) {
                  _pickedPosition = position.center!;
                  if (_addressText != 'custom_location_selected'.tr()) {
                    setState(() {
                      _addressText = 'custom_location_selected'.tr();
                    });
                  }
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.salahly.app',
                tileProvider: NetworkTileProvider(),
                errorTileCallback: (tile, error, stackTrace) {},
              ),
            ],
          ),

          
          const Center(
            child: Icon(Icons.location_pin, size: 48, color: Colors.red),
          ),

          
          Positioned(
            right: 16,
            bottom: 150,
            child: FloatingActionButton.small(
              backgroundColor: Colors.white,
              onPressed: _moveToCurrentLocation,
              child: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location, color: AppTheme.primaryNavy),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.accentAmber, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _addressText,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryNavy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _handleConfirmLocation,
                      child: Text(
                        'confirm_location'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
