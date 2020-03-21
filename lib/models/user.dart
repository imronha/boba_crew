// Creating a custom user model to only capture what information we need from result of sign-in

class User {
  final String uid;
  User({this.uid});
}

// Creating user data model to prepopulate data fields
class UserData {
  final String uid;
  final String name;
  // final String drinkName;
  final int sweetLevel;
  final int iceLevel;

  UserData({this.uid, this.sweetLevel, this.iceLevel, this.name});
}
