class UserModel {
  final String userId;
  final String userName;
  final String userEmail;
  final String userUid; // Assuming this is the unique identifier for the user

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userUid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userUid: json['userUid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userUid': userUid,
    };
  }
}
