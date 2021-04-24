import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/interventions.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<Interventions>> getInterventions() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Interventions> list = parseInterventions(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Interventions> parseInterventions(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Interventions>((json) => Interventions.fromJson(json))
        .toList();
  }
}
