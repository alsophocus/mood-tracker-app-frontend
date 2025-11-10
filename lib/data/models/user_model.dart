class UserModel {
  final int id;
  final String email;
  final String name;
  final String provider;
  final String? createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      provider: json['provider'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'provider': provider,
      if (createdAt != null) 'created_at': createdAt,
    };
  }
}
