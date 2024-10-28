import '../../domain/entities/user.dart';

class UserDto extends User {
  const UserDto({
    required super.id,
    required super.name,
    required super.email,
    required this.token,
    required this.refreshToken,
  });

  final String token;
  final String refreshToken;

  factory UserDto.fromMap(Map map) {
    return UserDto(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      email: map['email'],
      token: map['token'],
      refreshToken: map['refreshToken'],
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
    String? token,
    String? refreshToken,
  }) {
    return UserDto(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
