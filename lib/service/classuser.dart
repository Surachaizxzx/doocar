import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String email;
  User({
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
    );
  }
}

class UserService {
  static Future<List<User>> getUsers(String session) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/ko/user.php'),
      body: {'session': session},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
