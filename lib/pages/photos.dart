import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:full_api/models/user_photos/userPhotos.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});
  static const routeName = '/Photos';

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  late final Future<List<UsersPhotosModel>> _allPhoto;
  @override
  void initState() {
    _allPhoto = getAllPhotos();
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
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
              // ignore: prefer_const_constructors
              Color(0xff0f0c29),
              // ignore: prefer_const_constructors
              Color(0xff302b63),
              Color(0xff24243e)
            ])
            ),
        child: FutureBuilder(
          future: _allPhoto,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<UsersPhotosModel> photos = snapshot.data!;
              return GridView.builder(
                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200.0,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: photos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Image.network(photos[index].downloadUrl,
                        fit: BoxFit.cover),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<List<UsersPhotosModel>> getAllPhotos() async {
    try {
      String baseUrl = 'https://picsum.photos/v2';
      var response = await Dio().get('$baseUrl/list');
      var photos = (response.data as List);
      List<UsersPhotosModel> allPhotos = photos
          .map((userPhotos) => UsersPhotosModel.fromJson(userPhotos))
          .toList();
      if (response.statusCode == 200) {
        return allPhotos;
      }
      return [];
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}
