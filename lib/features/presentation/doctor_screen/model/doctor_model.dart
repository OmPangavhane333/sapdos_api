class DoctorModel {
  final String name;
  final String email;
  final String mobileNumber;
  final String address;
  final String age;
  final String specialization;
  final List<String> documents;
  final String role;
  final String description;
  final int experience;
  final String password;
  final String disease;
  final String id;
  final String uId;
  final DateTime createdOn;
  final DateTime updatedOn;
  final String createdBy;
  final String updatedBy;
  final bool archived;
  final int version;
  final bool active;
  final String dType;

  DoctorModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.age,
    required this.specialization,
    required this.documents,
    required this.role,
    required this.description,
    required this.experience,
    required this.password,
    required this.disease,
    required this.id,
    required this.uId,
    required this.createdOn,
    required this.updatedOn,
    required this.createdBy,
    required this.updatedBy,
    required this.archived,
    required this.version,
    required this.active,
    required this.dType,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      age: json['age'],
      specialization: json['specialization'],
      documents: List<String>.from(json['documents']),
      role: json['role'],
      description: json['description'],
      experience: json['experience'],
      password: json['password'],
      disease: json['disease'],
      id: json['id'],
      uId: json['uId'],
      createdOn: DateTime.parse(json['createdOn']),
      updatedOn: json['updatedOn'] == '0001-01-01T00:00:00'
          ? DateTime(0)
          : DateTime.parse(json['updatedOn']),
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      archived: json['archived'],
      version: json['version'],
      active: json['active'],
      dType: json['dType'],
    );
  }

  get uid => null;
}
