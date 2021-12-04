import 'package:flutter/material.dart';
import 'package:chat/utils.dart';

class RegisterScreen extends StatelessWidget {
  String userName = '',
      firstName = '',
      lastName = '',
      email = '',
      password = '';
  var formKey = GlobalKey<FormState>();
  static const String routeName = 'Register Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/pattern.png'),
          )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('SignUp'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'First Name'),
                    onChanged: (text) {
                      firstName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person), labelText: 'Last Name'),
                    onChanged: (text) {
                      lastName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your Last Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email_outlined),
                      labelText: 'Username',
                    ),
                    onChanged: (text) {
                      userName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please create a Username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail), labelText: 'E-mail'),
                    onChanged: (text) {
                      email = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your  Email';
                      }
                      if (!isValidEmail(email)) {
                        return 'Please enter a valid Email';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: 'Password'),
                    onChanged: (text) {
                      password = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your Password';
                      }
                      if (text.length < 9) {
                        return "password cant be less than 9 char/num/symbol";
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          createAccount();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Create account'),
                            Icon(
                              Icons.arrow_forward_rounded,
                            ),
                          ],
                        ),
                      ))
                ],
              )),
        ),
      ),
    );
  }

  void createAccount() {}
}