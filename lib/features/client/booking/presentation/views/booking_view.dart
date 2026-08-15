import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/core/utils/functions/location_helper.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/booking_view_body.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/pick_location_view.dart';


import 'package:salahly/features/client/home/data/models/technician_model.dart';

class BookingView extends StatefulWidget {
  final String? categoryName;
  final TechnicianModel? technician;

  const BookingView({super.key, this.categoryName, this.technician});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
 
  LatLng _selectedLatLng = const LatLng(30.0444, 31.2357);
 final String _addressTitle = 'current_location_title'.tr();
  String _addressDetails = 'loading_address'.tr();
  

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  Future<void> _initCurrentLocation() async {
    
    final position = await LocationHelper.getCurrentLocation();

    if (position != null && mounted) {
      final currentLatLng = LatLng(position.latitude, position.longitude);

      
      setState(() {
        _selectedLatLng = currentLatLng;
      });

      
      _fetchAddressNonBlocking(position.latitude, position.longitude);
    } else if (mounted) {
      setState(() {
        _addressDetails = 'pick_service_location'.tr();
      });
    }
  }

  
  Future<void> _fetchAddressNonBlocking(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng)
          .timeout(const Duration(seconds: 4));

      if (placemarks.isNotEmpty && mounted) {
        Placemark place = placemarks.first;
        final street = place.street ?? '';
        final locality = place.locality ?? '';

        setState(() {
          _addressDetails = (street.isNotEmpty || locality.isNotEmpty)
              ? '$street, $locality'
              : 'default_location_on_map'.tr();
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _addressDetails = 'default_location_on_map'.tr();
        });
      }
    }
  }

  Future<void> _handlePickLocation() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => PickLocationView(
          initialPosition: _selectedLatLng,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedLatLng = result['latLng'] as LatLng;
        _addressDetails = result['address'] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
        
    return Scaffold(
      appBar: AppBar(title: Text( 
        widget.categoryName != null 
        ? '${'request'.tr()}  ${widget.categoryName}'
        : '${'booking_title'.tr()} ${' Details'}',
        )
      ),
      body: BookingViewBody(
        categoryName: widget.categoryName,
       technician: widget.technician,
        selectedLatLng: _selectedLatLng,
        addressTitle: _addressTitle,
        addressDetails: _addressDetails,
        onPickLocationTap: _handlePickLocation,
      ),
    );
  }
}