import 'package:flutter/material.dart';
import 'package:chat/screens/create_new_room.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/pattern.png'),
          )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat App'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            newChatRoom();
          },
        ),
      ),
    );
  }

  void newChatRoom(){
    showModalBottomSheet<void>(
      isScrollControlled: false,
        backgroundColor: Colors.transparent,
        context:context,
        builder:(BuildContext context){
          return(
              const NewRoom()
          );
        });
  }
}
