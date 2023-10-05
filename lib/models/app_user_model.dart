class AppUser {
  final String name;
  final String surname;
  final String phoneNumber;
  final String profilePhoto;
  final String email;

  AppUser({
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'profilePhoto': profilePhoto,
      'email': email,
    };
  }

  AppUser.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        surname = map['surname'],
        phoneNumber = map['phoneNumber'],
        profilePhoto = map['profilePhoto'],
        email = map['email'];
}
