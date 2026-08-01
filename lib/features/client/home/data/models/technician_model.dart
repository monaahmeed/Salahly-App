class TechnicianModel {
  final String name;
  final String specialty;
  final double rating;
  final String?imageUrl;

  TechnicianModel({
    required this.name,
    required this.specialty,
    required this.rating,
     this.imageUrl,
  });
}