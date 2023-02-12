// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:full_api/models/comments/comments.dart';
// import '../../comments/comments.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});
  static const routeName = '/Comment Page';

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  late final Future<List<Comments>> _allCOmments;
  @override
  void initState() {
    _allCOmments = getAllComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                Color(0xff0f0c29),
                // ignore: prefer_const_constructors
                Color(0xff302b63),
                Color(0xff24243e)
              ])),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            // ignore: prefer_const_constructors
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
              Color(0xff0f0c29),
              Color(0xff302b63),
              Color(0xff24243e)
            ])),
        child: FutureBuilder(
          future: _allCOmments,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Comments> comments = snapshot.data!;
              return ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(
                      comments[index].email,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      comments[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.green,
                    children: [
                      ListTile(
                        title: Text(
                          comments[index].body,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<List<Comments>> getAllComments() async {
    try {
      String baseUrl = 'https://jsonplaceholder.typicode.com';
      var response = await Dio().get('$baseUrl/comments');
      var users = (response.data as List);
      List<Comments> comments =
          users.map((mail) => Comments.fromJson(mail)).toList();
      if (response.statusCode == 200) {
        return comments;
      }
      return [];
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}
