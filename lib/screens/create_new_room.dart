import 'package:chat/data/firestore.dart';

import 'package:chat/data/room.dart';
import 'package:chat/utils.dart';
import 'package:flutter/material.dart';
class NewRoom extends StatefulWidget {
  const NewRoom({Key? key}) : super(key: key);

  @override
  State<NewRoom> createState() => _NewRoomState();
}

class _NewRoomState extends State<NewRoom> {
 Category selectedCategory = categories[0];
  String name = '';
  String description = '';
  var ids = [Category.sportsId,Category.moviesId,Category.musicId];
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
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
                      minLines: 4,
                      maxLines: 4,
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
                      children:  [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Category :'
                          ,style: TextStyle(fontSize: 18,),),
                        ),
                        DropdownButton<Category>(
                          borderRadius: BorderRadius.circular(20),
                          isExpanded: false,
                          onChanged: (Category? newCat){
                            setState(() {
                              selectedCategory = newCat!;
                            });
                          },
                            value:selectedCategory ,
                            items: categories
                                .map<DropdownMenuItem<Category>>((category) {
                              // var category = Category.fromId(categoryId);
                              return DropdownMenuItem<Category>(
                                  value: category,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        category.image,
                                        width: 20,
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(category.name),
                                      )
                                    ],
                                  ));
                            }).toList()),

                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                          onPressed: () {
                            createRoom();
                          },
                          child: const Text('Create')),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
  void createRoom()async{
    if(formKey.currentState!.validate()){
     try {
       showLoading(context);
     await addRoomToFirestore(Room(id: '', name: name, description: description, categoryId: selectedCategory.id));
    hideLoading(context);
    Navigator.pop(context);
    }on Exception catch (error){
       showMessage(error.toString(), context, Colors.red);
     }
    }
  }
}

