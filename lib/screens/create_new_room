import 'package:flutter/material.dart';

class NewRoom extends StatefulWidget {
  const NewRoom({Key? key}) : super(key: key);

  @override
  State<NewRoom> createState() => _NewRoomState();
}

class _NewRoomState extends State<NewRoom> {
  String name = '';
  String description = '';
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Form(
            key: formKey,
              child: Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Room name'),
                onChanged: (text) {
                  name = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter room name';
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Room name'),
                onChanged: (text) {
                  description = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter room name';
                  }
                },
              ),

            ],
          ))
        ],
      ),
    );
  }
}
