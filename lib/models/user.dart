class User {
  int id;
  String name;
  String email;
  User({required this.id, required this.name, required this.email});
}

class UserDetail {
  static List<User> details = [];
}
