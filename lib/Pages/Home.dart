import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Config/API.dart';
import 'DetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> posts = [];
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

// fetch Post for Display
  Future<void> fetchPosts() async {
    try {
      final List<dynamic> fetchedPosts = await ApiService.fetchPosts();
      setState(() {
        posts = fetchedPosts;
        hasError = false; // reset code
      });
    } catch (e) {
      // The error here
      print('Error: $e');
      setState(() {
        hasError = true;
        errorMessage = 'Network error occurred. Pull down to refresh.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ICore'),
      ),
      // refresh indicator for get new post from api and show
      body: RefreshIndicator(
        onRefresh: fetchPosts,

        //widget for List user posts
        child: hasError
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: fetchPosts,
                      child: const Text(
                        'Refresh',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            title: posts[index]['title'],
                            body: posts[index]['body'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          title: Text(
                            posts[index]['title'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(posts[index]['body']),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
