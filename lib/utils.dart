import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

Future showMessage(String message, BuildContext context, color) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Loading...'),
              )
            ],
          ),
        );
      },barrierDismissible: true);
}

hideLoading(BuildContext context) {
  Navigator.pop(context);
}

class Category {
  static const String musicId = 'music';
  static const String moviesId = 'movies';
  static const String sportsId = 'sports';
  late String id;
  late String name;
  late String image='';


  Category(this.id, this.name, this.image);


  Category.byId(String id) {
    if (id == musicId) {
      this.id = musicId;
      name = 'Music';
      image = 'assets/images/music.png';
    } else if (id == moviesId) {
      this.id = moviesId;
      name = 'Movies';
      image = 'assets/images/movies.png';
    } else if (id == sportsId) {
      this.id = sportsId;
      name = 'Sports';
      image = 'assets/images/sports.png';
    }
  }
}

List<Category> categories = [
  Category.byId(Category.sportsId),
  Category.byId(Category.moviesId),
  Category.byId(Category.musicId),
];
