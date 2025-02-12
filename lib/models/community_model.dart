import 'package:communityapp/models/member_model.dart';

class CommunityModel {
  final String name;
  String? logo;
  final String image;
  String? info;
  final String category;

  List<MemberModel>? members;
  List<MemberModel>? coordinators;
  CommunityModel({
    required this.name,
    this.info,
    this.members,
    this.coordinators,
    this.logo,
    required this.category,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "info": info,
      "members": members?.map((member) => member.toJson()).toList(),
      "coordinators": coordinators?.map((coordinator) => coordinator.toJson()),
      "logo": logo,
      "category": category,
      "image": image,
    };
  }

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
      name: map['name'] ?? '',
      info: map['info'],
      logo: map['logo'],
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      members: map['members'] != null
          ? List<MemberModel>.from(
              (map['members'] as List).map((e) => MemberModel.fromMap(e)))
          : [],
      coordinators: map['coordinators'] != null
          ? List<MemberModel>.from(
              (map['coordinators'] as List).map((e) => MemberModel.fromMap(e)))
          : [],
    );
  }
}
