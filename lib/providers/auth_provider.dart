import 'package:flutter/material.dart';
import 'package:chat/data/user.dart' as app_user;

class AuthProvider extends ChangeNotifier{
  app_user.User? user;
  updateUser(app_user.User user){
    this.user = user;
    notifyListeners();
  }

}