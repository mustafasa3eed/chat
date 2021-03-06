import 'package:chat/data/firestore.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/utils.dart';
import 'package:chat/data/user.dart' as app_user;
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String userName = '',
      firstName = '',
      lastName = '',
      email = '',
      password = '';

  var formKey = GlobalKey<FormState>();
  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
 provider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/pattern.png'),
          )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SignUp'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Last Name'),
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
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
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
                      obscureText: true,
                      decoration: const InputDecoration(
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
                            children: const [
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
      ),
    );
  }

  void createAccount() async {
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var newUser = app_user.User(
          id: result.user!.uid,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          email: email);
      addUserToFirestore(newUser).then((value) {}).onError((error, stackTrace) {
        showMessage(error.toString(), context, Colors.red);
      });
      if (result.user != null) {
        showMessage('User Registered Successfully', context, Colors.green)
            .then((value) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        });
      }
    } catch (error) {
      showMessage(error.toString(), context, Colors.red);
    }
  }
}
