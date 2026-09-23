import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/booking/data/models/invoice_model.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/invoice_payment_sheet.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/rating_bottom_sheet.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/tracking_map_widget.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/tracking_technician_bottom_sheet.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/tracking_top_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveTechnicianTrackingView extends StatefulWidget {
  final String jobId;
  final String technicianName;
  final String? technicianPhone;
  final String? technicianImage;
  final LatLng clientLocation;
  final LatLng initialTechnicianLocation;

  const LiveTechnicianTrackingView({
    super.key,
    required this.jobId,
    required this.technicianName,
    this.technicianPhone = '01012345678',
    this.technicianImage,
    this.clientLocation = const LatLng(30.0444, 31.2357),
    this.initialTechnicianLocation = const LatLng(30.0380, 31.2280),
  });

  @override
  State<LiveTechnicianTrackingView> createState() =>
      _LiveTechnicianTrackingViewState();
}

class _LiveTechnicianTrackingViewState
    extends State<LiveTechnicianTrackingView> {
  final MapController _mapController = MapController();
  late LatLng _currentTechnicianLocation;
  Timer? _locationSimulationTimer;
  int _etaMinutes = 14;

  @override
  void initState() {
    super.initState();
    _currentTechnicianLocation = widget.initialTechnicianLocation;
    _startMovementSimulation();
  }

  void _startMovementSimulation() {
    _locationSimulationTimer = Timer.periodic(const Duration(seconds: 4), (
      timer,
    ) {
      if (!mounted) return;
      setState(() {
        final double newLat =
            _currentTechnicianLocation.latitude +
            (widget.clientLocation.latitude -
                    _currentTechnicianLocation.latitude) *
                0.08;
        final double newLng =
            _currentTechnicianLocation.longitude +
            (widget.clientLocation.longitude -
                    _currentTechnicianLocation.longitude) *
                0.08;

        _currentTechnicianLocation = LatLng(newLat, newLng);

        if (_etaMinutes > 1) {
          _etaMinutes--;
        }
      });
    });
  }

  @override
  void dispose() {
    _locationSimulationTimer?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  
  void _openInvoiceSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvoicePaymentSheet(
        invoice: InvoiceModel(
          bookingId: widget.jobId,
          technicianName: widget.technicianName,
          serviceTitle: 'AC Maintenance',
          laborCost: 200,
          spareParts: const [
            SparePartItem(name: 'AC Capacitor', price: 120),
            SparePartItem(name: 'Copper Filter', price: 40),
          ],
          tax: 15,
          discount: 25,
        ),
        onConfirmPayment: (method) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تأكيد الدفع بنجاح!'),
              backgroundColor: Color(0xFF16A34A),
            ),
          );

          _openRatingSheet();
        },
      ),
    );
  }

  void _openRatingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => RatingBottomSheet(
        technicianName: widget.technicianName,
        technicianImageUrl: widget.technicianImage,
        onSubmit: (rating, comment) {
          Navigator.pop(modalContext);

          if (context.mounted) {
            context.go(AppRouter.kHomeView);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: FloatingActionButton.extended(
          elevation: 2,
          onPressed: _openInvoiceSheet,
          backgroundColor: AppTheme.primaryNavy,
          icon: const Icon(Icons.receipt_long, color: Colors.white, size: 18),
          label: const Text(
            'Invoice',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          TrackingMapWidget(
            mapController: _mapController,
            clientLocation: widget.clientLocation,
            technicianLocation: _currentTechnicianLocation,
          ),

          TrackingTopNavBar(
            jobId: widget.jobId,
            onBack: () => Navigator.pop(context),
          ),

          TrackingTechnicianBottomSheet(
            etaMinutes: _etaMinutes,
            technicianName: widget.technicianName,
            technicianImage: widget.technicianImage,
            onCall: () {
              if (widget.technicianPhone != null) {
                _makeCall(widget.technicianPhone!);
              }
            },
            onChat: () {},
          ),
        ],
      ),
    );
  }
}
