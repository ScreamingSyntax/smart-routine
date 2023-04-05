import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:routine_app/controllers/local_storage.dart';
import 'package:routine_app/models/user.dart';

class UserController {
  String userEmail = "";
  int userID = 0;
  String userName = "";
  LocalStorage ac = LocalStorage();
  getProfile() async {
    userEmail = (await ac.readFromStorage('email'))!;
    print(userEmail);
    final response = await http.get(
      Uri.parse(
          'https://aaryansyproutineapplication.azurewebsites.net/api/users/${userEmail}'),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Barear ${await ac.readFromStorage('token') as String}'
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json["success"] == 1) {
        userName = json["message"][0]["name"];
        userID = json["message"][0]["id"];
        print(userID);
      }
      ac.writeToStorage('id', userID.toString());
      ac.writeToStorage('username', userName);
      UserDetail.details
          .add(User(id: userID, name: userName, email: userEmail));
      print(UserDetail.details);
    }
    // print(token.read(key: 'email') as String);
    // final responseJson = jsonDecode(response.body);
  }
}
