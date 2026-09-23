enum JobStatus { available, active, inProgress, scheduled, completed, cancelled }

class ServiceRequestModel {
  final String id;
  final String problemTitle;
  final String clientName;
  final String? clientPhone;
  final String? clientImage;
  final double distanceInKm;
  final String locationName;
  final double offeredPrice;
  final String problemDescription;
  final List<String> problemPhotos;
  final bool isUrgent;
  final JobStatus status;
  final DateTime? createdAt;
  final String? scheduledTime;
  final double? rating;
  final String? reviewNote;
  final double? latitude;
  final double? longitude;

  const ServiceRequestModel({
    required this.id,
    required this.problemTitle,
    required this.clientName,
    this.clientPhone,
    this.clientImage,
    required this.distanceInKm,
    required this.locationName,
    required this.offeredPrice,
    required this.problemDescription,
    this.problemPhotos = const [],
    this.isUrgent = false,
    this.status = JobStatus.available,
    this.createdAt,
    this.scheduledTime,
    this.rating,
    this.reviewNote,
    this.latitude,
    this.longitude,
  });

  ServiceRequestModel copyWith({
    String? id,
    String? problemTitle,
    String? clientName,
    String? clientPhone,
    String? clientImage,
    double? distanceInKm,
    String? locationName,
    double? offeredPrice,
    String? problemDescription,
    List<String>? problemPhotos,
    bool? isUrgent,
    JobStatus? status,
    DateTime? createdAt,
    String? scheduledTime,
    double? rating,
    String? reviewNote,
    double? latitude,
    double? longitude,
  }) {
    return ServiceRequestModel(
      id: id ?? this.id,
      problemTitle: problemTitle ?? this.problemTitle,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientImage: clientImage ?? this.clientImage,
      distanceInKm: distanceInKm ?? this.distanceInKm,
      locationName: locationName ?? this.locationName,
      offeredPrice: offeredPrice ?? this.offeredPrice,
      problemDescription: problemDescription ?? this.problemDescription,
      problemPhotos: problemPhotos ?? this.problemPhotos,
      isUrgent: isUrgent ?? this.isUrgent,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      rating: rating ?? this.rating,
      reviewNote: reviewNote ?? this.reviewNote,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  String get timeAgoDisplay {
    if (scheduledTime != null && scheduledTime!.isNotEmpty) {
      return scheduledTime!;
    }
    if (createdAt == null) return 'Just now';

    final diff = DateTime.now().difference(createdAt!);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      id: json['id'] as String,
      problemTitle: json['problemTitle'] as String,
      clientName: json['clientName'] as String,
      clientPhone: json['clientPhone'] as String?,
      clientImage: json['clientImage'] as String?,
      distanceInKm: (json['distanceInKm'] as num).toDouble(),
      locationName: json['locationName'] as String,
      offeredPrice: (json['offeredPrice'] as num).toDouble(),
      problemDescription: json['problemDescription'] as String,
      problemPhotos: (json['problemPhotos'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isUrgent: json['isUrgent'] as bool? ?? false,
      status: JobStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => JobStatus.available,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      scheduledTime: json['scheduledTime'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewNote: json['reviewNote'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problemTitle': problemTitle,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'clientImage': clientImage,
      'distanceInKm': distanceInKm,
      'locationName': locationName,
      'offeredPrice': offeredPrice,
      'problemDescription': problemDescription,
      'problemPhotos': problemPhotos,
      'isUrgent': isUrgent,
      'status': status.name,
      'createdAt': createdAt?.toIso8601String(),
      'scheduledTime': scheduledTime,
      'rating': rating,
      'reviewNote': reviewNote,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}