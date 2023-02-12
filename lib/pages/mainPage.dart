// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:full_api/pages/comments.dart';
import 'package:full_api/pages/contacPage.dart';
import 'package:full_api/pages/photos.dart';
import 'package:lottie/lottie.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const routeName = '/';
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xff0f0c29),
                Color(0xff302b63),
                Color(0xff24243e)
              ])),
        ),
      ),
      drawer: const NavigationDrawer(),
      body: Scaffold(
        body: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff0f0c29), Color(0xff302b63), Color(0xff24243e)],
          )),
          child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_Vt1ZLYjfXT.json')
          ),
        ),
      );
    
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildItemMenu(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  Widget buildItemMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        children: [
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contacts'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ContactPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('Emails'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Comment()));
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Photos'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Photos()));
            },
          ),
        ],
      ),
    );
  }
}
