// A global user object that is updated as the user log

class CurrentUser {
  String uuid = '';
  String firstName = '';
  String lastName = '';
  String username = '';
  String password = '';
  String avatarImage = '';

  void setUUID(String id) {
    uuid = id;
  }

  String getUUID() {
    return uuid;
  }

  void setFirstName(String name) {
    firstName = name;
  }

  String getFirstName() {
    return firstName;
  }

  void setLastName(String name) {
    lastName = name;
  }

  String getLastName() {
    return lastName;
  }

  void setUsername(String name) {
    username = name;
  }

  String getUsername() {
    return username;
  }

  void setPassword(String pass) {
    password = pass;
  }

  String getPassword() {
    return password;
  }

  void setAvatarImage(String avatar) {
    avatarImage = avatar;
  }

  String getAvatarImage() {
    return avatarImage;
  }

  void clearData() {
    firstName = '';
    lastName = '';
    username = '';
    password = '';
  }
}
