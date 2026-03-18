// models/user_entity.dart
class UserEntity {
  final String? id;
  final String name;
  final String email;
  final String birthDate; // Formato ISO: yyyy-MM-dd

  UserEntity({this.id, required this.name, required this.email, required this.birthDate});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthDate: json['birthDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'birthDate': birthDate,
  };
}
