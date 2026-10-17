class UserProfile {
  final String name;
  final String email;
  final String profilePictureUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });
}

final dummyUser = UserProfile(
  name: 'John Doe',
  email: 'john.doe@example.com',
  profilePictureUrl: 'https://picsum.photos/seed/user/150/150',
);
