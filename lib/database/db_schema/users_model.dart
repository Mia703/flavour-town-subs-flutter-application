const String usersTableName = 'users';

class UsersColumns {
  static final List<String> values = [
    uuid,
    firstName,
    lastName,
    username,
    password
  ];

  static const String uuid = '_uuid';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String username = 'username';
  static const String password = 'password';
}

class User {
  final String uuid;
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  const User({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
  });

  static User fromJSON(Map<String, Object?> json) => User(
    uuid: json[UsersColumns.uuid] as String,
    firstName: json[UsersColumns.firstName] as String,
    lastName: json[UsersColumns.lastName] as String,
    username: json[UsersColumns.username] as String,
    password: json[UsersColumns.password] as String,
  );

  Map<String, Object?> toJSON() => {
        UsersColumns.uuid: uuid,
        UsersColumns.firstName: firstName,
        UsersColumns.lastName: lastName,
        UsersColumns.username: username,
        UsersColumns.password: password,
      };

  User copy({
    String? uuid,
    String? firstName,
    String? lastName,
    String? username,
    String? password,
  }) =>
      User(
        uuid: uuid ?? this.uuid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        password: password ?? this.password,
      );
}
