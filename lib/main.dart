import 'package:flutter/material.dart';
import 'package:full_api/pages/comments.dart';
import 'package:full_api/pages/contacPage.dart';
import 'package:full_api/pages/mainPage.dart';
import 'package:full_api/pages/photos.dart';

main(){
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        MainPage.routeName :(context) => const MainPage(),
        ContactPage.routeName :(context) =>  const ContactPage(),
        Comment.routeName :(context) => const Comment(),
        Photos.routeName :(context) => const Photos()
      },
    );
  }
}