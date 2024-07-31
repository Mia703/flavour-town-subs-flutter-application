// A global user object that is updated as the user log

class CurrentUser {
  String firstName = '';
  String lastName = '';
  String username = '';
  String password = '';

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

  void clearData() {
    firstName = '';
    lastName = '';
    username = '';
    password = '';
  }
}
