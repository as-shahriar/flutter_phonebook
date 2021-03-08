class User {
  static const tblUser = 'user';
  static const colId = 'id';
  static const colEmail = 'email';
  static const colPassword = 'password';

  int id;
  String email;
  String password;

  User();
  User.init(this.email, this.password);
  User.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    email = map[colEmail];
    password = map[colPassword];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colEmail: email, colPassword: password};
    if (id != null) map[colId] = id;
    return map;
  }
}
