class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String bio;
  final String profileImageUrl;
  final int followers;
  final int following;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      bio: map['bio'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
    );
  }
}
