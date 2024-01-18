class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final int? balance;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      balance: json['balance'],
    );
  }
}
