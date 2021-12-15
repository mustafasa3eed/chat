import 'package:chat/data/firestore.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', password = '';
  late AuthProvider provider;
  var formKey = GlobalKey<FormState>();

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
          title: const Text('Login'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.mail),
                            labelText: 'E-mail'),
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
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye),
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                          height: 45,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                login();
                              }
                            },
                            child: Text('LOGIN')),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: const Text('Register now')),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    try {
      showLoading(context);
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        var firestoreUser = await getUserById(result.user!.uid);
        if (firestoreUser != null) {
          provider.updateUser(firestoreUser);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      }
    } catch (error) {
      hideLoading(context);
      showMessage('Invalid email or password', context, Colors.red);
    }
  }
}
