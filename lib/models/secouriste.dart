class Secouriste {
  final String id;
  final String imgUrl;
  final String name;
  final String email;
  final String address;
  final int age;
  bool isFree;
  final String phone;

  Secouriste(
      {this.id,
      this.imgUrl,
      this.name,
      this.email,
      this.age,
      this.isFree,
      this.phone,
      this.address});

  factory Secouriste.fromJson(Map<dynamic, dynamic> json) {
    var secourist = json["Secouriste"];

    return Secouriste(
        id: secourist["id"],
        imgUrl: secourist["token"],
        name: secourist["name"],
        email: secourist["email"],
        isFree: secourist['isFree'],
        phone: secourist['phone'],
        address: secourist['address'],
        age: secourist['age']);
  }
}
