import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Api Class...
class ApiService {
  static const String BaseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String Post = 'posts';

// User Post List fetch Method...
  static Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse('$BaseUrl$Post'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
