class UserModel {
  String? email;
  String? name;
  String? title;
  String? id;
  String?image;
  List following;
  List followers;
  UserModel(
      {
        required this.email,
      required this.image,
      this.id,
      required this.name,
      required this.title,
        required this.followers,
        required this.following

      });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      email: map['email'],
      image: map['image'],
      id: map['id'],
      name: map['name'],
      title: map['title'],
      followers: map['followers'],
      following: map['following']
  );


  Map<String, dynamic> toMap({required id}) => {
    'id': id,
    'email': email,
    'image': image,
    'name': name,
    'title': title,
    'followers':followers,
    'following' : following
  };


}
