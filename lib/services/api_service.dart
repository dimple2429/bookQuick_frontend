import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const baseUrl = "https://bookquick-backend.onrender.com";

  static Future login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    print("RAW RESPONSE: ${res.body}");
    final data = jsonDecode(res.body);

    if (data['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data['token']);
    }

    return data;
  }

  static Future getServices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final res = await http.get(
      Uri.parse("$baseUrl/services"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(res.body);
  }

  static Future bookService(Map data) async {
    final res = await http.post(
      Uri.parse("$baseUrl/bookings"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }
}