class Interventions {
  String name;
  String region;

  Interventions({this.name, this.region});

  factory Interventions.fromJson(Map<String, dynamic> json) {
    return Interventions(
      name: json["name"] as String,
      region: json["address"]["city"] as String,
    );
  }
}
