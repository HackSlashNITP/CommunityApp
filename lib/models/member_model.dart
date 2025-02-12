class MemberModel {
  final String name;
  final String branch;
  String? image;
  String? linkedin;
  final String position;
  MemberModel(
      {required this.name,
      required this.branch,
      this.image,
      this.linkedin,
      required this.position});

  toJson() {
    return {
      "name": name,
      "branch": branch,
      "image": image,
      "position": position,
      "linkedin": linkedin,
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
        name: map['name'],
        branch: map['branch'],
        image: map['image'],
        position: map['position'],
        linkedin: map['linkedin']);
  }
}
