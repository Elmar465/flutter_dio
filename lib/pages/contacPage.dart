import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dio/dio.dart';
import 'package:full_api/models/user_model/user_model.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
  static const routeName = 'ContactPage';
}

class _ContactPageState extends State<ContactPage> {
  late final Future<List<UserModel>> _allUser;
  @override
  void initState() {
    _allUser = getAllUser();
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
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            // ignore: prefer_const_constructors
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xff0f0c29),
              Color(0xff302b63),
              Color(0xff24243e)
            ])
            ),
        child: FutureBuilder(
          future: _allUser,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      users[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      users[index].email,
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        users[index].id.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return CircularProgressIndicator(
                color: Colors.white,
              );
            }
          }),
        ),
      ),
    );
  }

// Expansional tile (commentsleri getir)
  Future<List<UserModel>> getAllUser() async {
    try {
      String base_Url = 'https://jsonplaceholder.typicode.com';
      var response = await Dio().get('$base_Url/users');
      var users = (response.data as List);
      List<UserModel> allUsers =
          users.map((user) => UserModel.fromJson(user)).toList();
      //response statuscode olmalidi - sen response data yazmishdin
      // bildim brat opurem
      //buyur opurem bashqa sual var?
      if (response.statusCode == 200) {
        return allUsers;
      }
      return [];
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}
