import 'package:chat/data/user.dart';

Future<void> addUserToFirestore(User user){
 return User.withConverter()
      .doc(user.id)
      .set(user);
}