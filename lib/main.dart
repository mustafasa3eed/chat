import 'package:chat/providers/auth_provider.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (buildContext) => AuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(elevation: 0, backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.transparent,
        primarySwatch: Colors.blue,
      ),
      routes: {
        RegisterScreen.routeName: (buildContext) => const RegisterScreen(),
        LoginScreen.routeName: (buildContext) => const LoginScreen(),
        HomeScreen.routeName: (buildContext) => const HomeScreen(),
      },
      initialRoute:
          provider.isLoggedIn() ? HomeScreen.routeName : LoginScreen.routeName,
    );
  }
}
