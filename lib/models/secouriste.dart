class Secouriste {
  final String id;
  final String imgUrl;
  final String name;
  final String cin;
  final String email;
  final String gouvernorat;
  final int age;
  bool isFree;
  bool isAdmin;
  bool isNormalUser;
  bool isActivated;
  final String phone;

  Secouriste(
      {this.id,
      this.imgUrl,
      this.cin,
      this.name,
      this.email,
      this.age,
      this.isFree,
      this.isAdmin,
      this.isActivated,
      this.isNormalUser,
      this.phone,
      this.gouvernorat});

  factory Secouriste.fromJson(Map<dynamic, dynamic> json) {
    var secourist = json["Secouriste"];

    return Secouriste(
        id: secourist["id"],
        // imgUrl: secourist["token"],
        cin: secourist["cin"],
        name: secourist["name"],
        email: secourist["email"],
        isFree: secourist['isFree'],
        isActivated: secourist['isActivated'],
        isAdmin: secourist['isAdmin'],
        isNormalUser: secourist['isNormalUser'],
        phone: secourist['phone'],
        gouvernorat: secourist['gouvernorat'],
        age: secourist['age']);
  }
}
