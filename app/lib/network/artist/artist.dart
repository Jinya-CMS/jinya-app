class Artist {
  int id;
  String artistName;
  String email;
  String profilePicture;
  List<String> roles;

  Artist({
    this.id,
    this.artistName,
    this.email,
    this.profilePicture,
    this.roles,
  });

  factory Artist.fromMap(Map<String, dynamic> data) {
    final roles = List<String>();
    final rolesFromMap = data['roles'];
    for (final role in rolesFromMap) {
      roles.add(role.toString());
    }

    return Artist(
      id: data['id'],
      email: data['email'],
      artistName: data['artistName'],
      profilePicture: data['profilePicture'],
      roles: roles,
    );
  }
}
