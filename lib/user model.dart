class UserModel {
  static const String collectionName="Users";
  String id;
  String email;
  String phone;
  String userName;

  bool emailVerified;

  UserModel({
    required this.id,
    required this.email,
    this.phone = "",
    this.emailVerified = false,
    required this.userName,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    email: json['email'],
    phone: json['phone'],
    emailVerified: json['emailVerified'],
    userName: json['userName'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phone": phone,
      "emailVerified": emailVerified,
      "userName": userName,
    };
  }
}