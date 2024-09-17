import '../../domain/entities/user.dart';

class UserDto extends User {
  const UserDto({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserDto.fromMap(Map map) {
    return UserDto(
      id: map['id'],
      name: map['userName'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': name,
      'email': email,
    };
  }

  UserDto copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserDto(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
