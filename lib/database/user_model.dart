class User {
  final String uuid;
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  User({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
  });

  // convert the User into a Map. The keys correspond to column names
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'firstName': firstName,
      'lastName': lastName,
      'userName': username,
      'password': password,
    };
  }

  // extracts a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        uuid: map['uuid'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        username: map['username'],
        password: map['password']);
  }

  // // extracts a User object from a Map
  // User.fromMap(Map<String, dynamic> map)
  //     : uuid = map['uuid'],
  //       firstName = map['firstName'],
  //       lastName = map['lastName'],
  //       username = map['username'],
  //       password = map['password'];
}
