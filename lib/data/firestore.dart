import 'package:chat/data/room.dart';
import 'package:chat/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUserToFirestore(User user){
 return User.withConverter()
      .doc(user.id)
      .set(user);
}


Future<User?> getUserById(String id)async{
 DocumentSnapshot<User> result = await User.withConverter().doc().get();
 return result.data();
}


Future<void> addRoomToFirestore(Room room){
 var docRef = Room.withConverter()
     .doc();
 room.id= docRef.id;
 return docRef.set(room);
}