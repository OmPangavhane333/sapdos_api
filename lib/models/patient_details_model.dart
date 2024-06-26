import 'dart:convert';

PatientDetailsModel patientDetailsModelFromJson(String str) =>
    PatientDetailsModel.fromJson(json.decode(str));

String patientDetailsModelToJson(PatientDetailsModel data) =>
    json.encode(data.toJson());

class PatientDetailsModel {
  PatientDetailsModel({
    required this.name,
    required this.email,
    required this.age,
    this.documents,
    required this.description,
  });

  String name;
  String email;
  String age;
  dynamic documents;
  String description;

  factory PatientDetailsModel.fromJson(Map<String, dynamic> json) =>
      PatientDetailsModel(
        name: json["name"],
        email: json["email"],
        age: json["age"],
        documents: json["documents"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "age": age,
        "documents": documents,
        "description": description,
      };
}
