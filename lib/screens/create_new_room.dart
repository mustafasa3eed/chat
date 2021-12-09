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
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      'Create a new room',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                     Image.asset('assets/images/group_logo.png'),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
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
                      maxLength: 40,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter room Description';
                        }
                      },
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Category'),
                        ),
                        // DropdownButton(
                        //   onChanged: ,
                        //   value: ,
                        //     items: [
                        //   DropdownMenuItem(child: Text('hey'))
                        // ]),
                      ],
                    ),

                    Container(
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25)))),
                          onPressed: () {},
                          child: const Text('Create')),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
