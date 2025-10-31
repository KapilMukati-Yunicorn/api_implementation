import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api_implementation/models/userModel.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<UserModel> usersList = [];
  
  Future<List<UserModel>> fetchUsersData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var usersData = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map <String, dynamic> i in usersData){
         usersList.add(UserModel.fromJson(i));
      }
      return usersList;
    }
    return usersList;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
