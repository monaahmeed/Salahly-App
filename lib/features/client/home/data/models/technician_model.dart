// class TechnicianModel {
//   final String name;
//   final String specialty;
//   final double rating;
//   final String?imageUrl;

//   TechnicianModel({
//     required this.name,
//     required this.specialty,
//     required this.rating,
//      this.imageUrl,
//   });
// }
class TechnicianModel {
  final String id;
  final String name;
  final String specialty;
  final String? title;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final String? imageUrl;

  TechnicianModel({
    required this.id,
    required this.name,
    required this.specialty,
    this.title,
    required this.rating,
    this.reviewsCount = 0,
    this.experienceYears = 0,
    this.imageUrl,
  });

  // 🔄 دالة تحويل الـ JSON لـ Object
  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      title: json['title'] ?? json['specialty'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      experienceYears: json['experienceYears'] ?? 0,
      imageUrl: json['imageUrl'],
    );
  }
}