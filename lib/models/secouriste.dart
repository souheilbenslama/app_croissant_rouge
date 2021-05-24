class Secouriste {
  final String id;
  final String photo;
  final String name;
  final String cin;
  final String email;
  final String gouvernorat;
  final int age;
  bool isFree;
  bool isAdmin;
  bool isNormalUser;
  bool isActivated;
  String verificationCode;
  final String phone;

  Secouriste(
      {this.id,
      this.photo,
      this.cin,
      this.name,
      this.email,
      this.age,
      this.isFree,
      this.isAdmin,
      this.isActivated,
      this.isNormalUser,
      this.phone,
      this.gouvernorat,
      this.verificationCode});

  factory Secouriste.fromJson(Map<dynamic, dynamic> json) {
    var secourist = json;

    return Secouriste(
        id: secourist["_id"],
        photo: secourist["photo"],
        cin: secourist["cin"],
        name: secourist["name"],
        email: secourist["email"],
        isFree: secourist['isFree'],
        isActivated: secourist['isActivated'],
        isAdmin: secourist['isAdmin'],
        isNormalUser: secourist['isNormalUser'],
        phone: secourist['phone'],
        gouvernorat: secourist['gouvernorat'],
        verificationCode: secourist['verificationCode'],
        age: secourist['age']);
  }

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "isFree": isFree,
        "phone": phone,
        "address": gouvernorat,
        "photo": photo,
        "age": age,
      };
}
