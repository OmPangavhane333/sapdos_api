// doctor_model.dart
class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      specialization: json['specialization'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      profilePictureUrl: json['profilePictureUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
