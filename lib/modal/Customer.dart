
class Customer {
  final int id;
  final String fullName;
  final String phone;
  final String address;
  final String email;
  final String username;
  final String password;
  final String token;
  final bool verified;

  Customer({
    this.id,
    this.email,
    this.username,
    this.password,
    this.fullName,
    this.address,
    this.token,
    this.phone,
    this.verified
  });

  Customer fromJson(Map<String, dynamic> map) {

    return Customer(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      fullName: map['fullName'],
      verified: map['verified'],
      address: map['address'],
      token: map['token'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "password": password,
    "fullName": fullName,
    "address": address,
    "token": token,
    "phone": phone,
    "verified": verified
  };
}
