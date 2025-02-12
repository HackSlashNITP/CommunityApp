class MilestoneModel {
  final String topic;
  String? info;
  MilestoneModel({required this.topic, this.info});

  toJson() {
    return {
      "topic": topic,
      "info": info,
    };
  }

  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(topic: json['topic'], info: json['info']);
  }
}

class CourseModel {
  final List<MilestoneModel> milestones;
  final String title;
  final String subtitle;
  final String image;
  CourseModel(
      {required this.milestones,
      required this.title,
      required this.subtitle,
      required this.image});

  toJson() {
    return {
      "milestones": milestones.map((milestone) {
        return milestone.toJson();
      }),
      "title": title,
      "subtitle": subtitle,
      "image": image,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      milestones: json['milestones'] != null
          ? List<MilestoneModel>.from((json['milestones'] as List)
              .map((e) => MilestoneModel.fromJson(e)))
          : [],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }
}
