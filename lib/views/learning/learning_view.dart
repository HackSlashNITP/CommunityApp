import 'package:communityapp/res/colors.dart';
import 'package:communityapp/views/learning/ai_chat_view.dart';
import 'package:communityapp/views/learning/blogs/blogpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/ai_chat_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../widgets/learning_card.dart';
import '../youtube/PlaylistsScreen.dart';

class LearningView extends StatelessWidget {
  LearningView({super.key, this.name, this.uid});

  final double height = Get.height;
  final double width = Get.width;

  final String? name;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    final user = types.User(
      id: uid ?? "random_17263274",
      firstName: name ?? "user",
    );
    Get.put(AiChatController(user: user));
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorPalette.bgColor,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: SvgPicture.asset('assets/svgs/box.svg'),
            ),
            Positioned(
              right: 0,
              top: Get.height * 0.1,
              child: SvgPicture.asset('assets/svgs/box.svg'),
            ),
            Positioned(
              top: Get.height * 0.4,
              left: 0,
              child: SvgPicture.asset('assets/svgs/rectangle.svg'),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Learning\nOptions",
                            style: TextStyle(
                              color: ColorPalette.pureWhite,
                              fontWeight: FontWeight.w900,
                              fontSize: width * 0.1,
                            )),
                        Image.asset(
                          'assets/learning/book.png',
                          height: width * 0.15,
                          width: width * 0.15,
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=>AiChatView());
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                            color: ColorPalette.pureWhite.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("AI Search ?",
                                style: TextStyle(
                                  color: ColorPalette.pureWhite,
                                  fontSize: width * 0.05,
                                )),
                            Icon(
                              Icons.search,
                              color: ColorPalette.pureWhite,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        children: learningWidget,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  final List<LearningCard> learningWidget = [
    LearningCard(
      imagePath: "assets/learning/roadmap_icon.png",
      cardName: "Roadmap",
      onTap: () => print("Roadmap tapped"),
    ),
    LearningCard(
      imagePath: "assets/learning/playlist_icon.png",
      cardName: "Playlist",
      onTap: () => Get.to(
        () => PlaylistsScreen(
          channelId: 'UCFEHqTxq-jVK_jl263fz0kg',
        ),
      ),
    ),
    LearningCard(
        imagePath: "assets/learning/projects_icon.png",
        cardName: "Blogs",
        onTap: () => Get.to(Blog_Page())),
    LearningCard(
      imagePath: "assets/learning/pdf_icon.png",
      cardName: "Pdf Notes",
      onTap: () => print("Pdf Notes tapped"),
    ),
    LearningCard(
      imagePath: "assets/learning/html.png",
      cardName: "Links",
      onTap: () => print("Important Links"),
    )
  ];
}
