class UserModel {
  final String nama;
  final String email;
  final String phoneNumber;
  final String username;
  final String password;

  const UserModel({
    required this.nama,
    required this.email,
    required this.phoneNumber,
    required this.username,
    required this.password,
  });

  static UserModel fromJson(json) => UserModel(
        nama: json['nama'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        username: json['username'],
        password: json['password'],
      );
}
