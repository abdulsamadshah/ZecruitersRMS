class UserModel {
  final String name;
  final String email;
  final String mobileNumber;
  final String? whatsappNumber;

  UserModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    this.whatsappNumber,
  });

  // Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      mobileNumber: json['mobileNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'whatsappNumber': whatsappNumber,
    };
  }
}
