class AddUser {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String uid;
  final String dateTime;

  const AddUser({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.uid,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'fname': firstName,
      'lname': lastName,
      'username': userName,
      'email': email,
      'password': password,
      'id': uid,
      'registerDate': dateTime,
    };
  }
}
