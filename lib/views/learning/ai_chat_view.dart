import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../controllers/ai_chat_controller.dart';
import '../../res/colors.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AiChatController controller = Get.find<AiChatController>();
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
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 30,
                            color: ColorPalette.pureWhite,
                          )),
                      Expanded(
                        child: Text(
                          "AI Chat",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorPalette.pureWhite,
                            fontWeight: FontWeight.w900,
                            fontSize: Get.width * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Obx(
                      () => Chat(
                        messages: controller.messages.toList(),
                        onSendPressed: (partialText) {
                          final textMessage = types.TextMessage(
                            author: controller.user,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                            id: const Uuid().v4(),
                            text: partialText.text,
                          );
                          controller.addMessage(textMessage);
                          controller.getAiResponseStream(partialText.text);
                        },
                        user: controller.user,
                        showUserAvatars: true,
                        showUserNames: true,
                        timeFormat: DateFormat('hh:mm a'),
                        dateFormat: DateFormat('dd MMM, yyyy'),
                        theme: DefaultChatTheme(
                          primaryColor: ColorPalette.darkSlateBlue,
                          secondaryColor: ColorPalette.navyBlack,
                          backgroundColor: Colors.transparent,
                          inputBackgroundColor:
                              const Color.fromARGB(255, 28, 116, 63),
                          inputBorderRadius:
                              BorderRadius.all(Radius.circular(16)),
                          inputTextColor: ColorPalette.pureWhite,
                          inputMargin: EdgeInsets.all(12),
                          inputTextCursorColor:
                              const Color.fromARGB(255, 230, 255, 4),
                          messageInsetsVertical: 8,
                          messageInsetsHorizontal: 16,
                          receivedMessageBodyTextStyle: TextStyle(
                            color: ColorPalette.pureWhite,
                            fontSize: 16,
                          ),
                          sentMessageBodyTextStyle: TextStyle(
                            color: ColorPalette.pureWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
