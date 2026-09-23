class TechnicianReviewModel {
  final String id;
  final String clientName;
  final String? clientImage;
  final double rating;
  final String comment;
  final String serviceTitle;
  final DateTime createdAt;

  const TechnicianReviewModel({
    required this.id,
    required this.clientName,
    this.clientImage,
    required this.rating,
    required this.comment,
    required this.serviceTitle,
    required this.createdAt,
  });

  String get formattedDate {
    return '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
  }
}