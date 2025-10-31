import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_implementation/models/PostsModel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postsList = [];

  Future<List<PostsModel>> getPostsApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postsList.add(PostsModel.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Implementation"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostsApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("Loading....."));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error : ${snapshot.error}"));
                } else {
                  return ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (context, index) {
                      return Text(postsList[index].id.toString());
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
