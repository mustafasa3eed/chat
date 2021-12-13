import 'package:chat/data/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/create_new_room.dart';
class HomeScreen extends StatefulWidget {

  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = 'One';

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
        body: FutureBuilder<QuerySnapshot<Room>>(
          future: Room.withConverter().get(),
          builder: (builder,snapshot){
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var roomslist = snapshot.data!.docs.map((e) => e.data()).toList();
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8),
                itemBuilder: (buildContext,index){
                  return Text(roomslist[index].name);
                },itemCount: roomslist.length,);
          }
        ),
      ),
    );
  }

  void newChatRoom(){
    showModalBottomSheet<void>(
      isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context:context,
        builder:(BuildContext context){
          return(
              const NewRoom()
          );
        });
  }
}
