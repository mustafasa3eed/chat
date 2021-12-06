import 'package:flutter/material.dart';
import 'package:chat/data/user.dart' as AppUser;

class AuthProvider extends ChangeNotifier{
  AppUser.User? user = null;
  updateUser(AppUser.User user){
    this.user = user;
    notifyListeners();
  }

}