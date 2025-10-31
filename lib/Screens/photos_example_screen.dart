import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/photosModel.dart';
import 'package:http/http.dart' as http;

class PhotosExampleScreen extends StatefulWidget {
  const PhotosExampleScreen({super.key});

  @override
  State<PhotosExampleScreen> createState() => _PhotosExampleScreenState();
}

class _PhotosExampleScreenState extends State<PhotosExampleScreen> {
  final List<Photos> newPhotosList = [];

  Future<List<Photos>> getPhotoApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );
    var photosData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in photosData) {
        Photos photos = Photos(url: i['url'], title: i['title']);
        newPhotosList.add(photos);
      }
      return newPhotosList;
    }
    return newPhotosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading....'));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
                          ),
                        ),
                        title: Column(
                          children: [Text(item.title), Text(item.url)],
                        ),
                      );
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
