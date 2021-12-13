import 'package:chat/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  static const String collectionName = 'Rooms';
  String id;
  String name;
  String description;
  String categoryId;
  Room(
      {required this.id,
      required this.name,
      required this.description,
      required this.categoryId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            name: json['name'] as String,
            description: json['description'] as String,
            categoryId: json['categoryId'] as String);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryId': categoryId
    };
  }

  static CollectionReference<Room> withConverter() {
    return FirebaseFirestore.instance.collection(collectionName).withConverter(
        fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
        toFirestore: (room, _) => room.toJson());
  }
}
class RoomWidget extends StatelessWidget {

  RoomWidget(this.room);
  Room room;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(Category.byId(room.categoryId).imagePath),
          Text(room.name)
        ],
      ),
    );
  }
}

