import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/models/user.dart';

User? loggedinuser;

List<User> users = [
  User(
    name: 'Sam',
    surename: 'Blewitt',
    email: 'john.doe@myport.ac.uk',
    year: 2023,
    // comitteeSocieties: [],
    comitteeSocieties: [socieities[0], socieities[1]],
    societies: [socieities[2]], password: 'test',
  ),
  User(
    name: 'John',
    surename: 'Doe',
    email: 'example.user@myport.ac.uk',
    year: 2023,
    comitteeSocieties: [],
    societies: [socieities[0], socieities[1], socieities[2]],
    password: 'test',
  ),
  User(
    name: 'Admin',
    surename: 'admin',
    email: 'admin@myport.ac.uk',
    year: 2023,
    comitteeSocieties: [
      socieities[0],
      socieities[1],
      socieities[2],
      socieities[3]
    ],
    societies: [],
    password: 'admin',
  )
];

bool login(String email, String password) {
  for (var user in users) {
    if (user.email == email && user.password == password) {
      loggedinuser = user;
      return true;
    }
  }
  loggedinuser = null; // Set to null if no match is found
  return false;
}

void logoutUser() {
  loggedinuser = null;
}

User? getLoggedInUser() {
  return loggedinuser;
}
