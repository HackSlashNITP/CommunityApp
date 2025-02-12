import 'package:communityapp/controllers/home_controller.dart';
import 'package:communityapp/views/chat/chat_view.dart';
import 'package:communityapp/views/chat/meeting_page.dart';
import 'package:communityapp/views/home/home_view.dart';
import 'package:communityapp/views/learning/learning_view.dart';
import 'package:communityapp/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  final String userid;
  final BottomNavController bottomNavController =
      Get.put(BottomNavController(), permanent: true);

  MainView({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeView(),
      ChatView(username: userid),
      meetingpage(username: userid),
      LearningView(),
      ProfileView(username: userid),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: bottomNavController.selectedIndex.value,
            children: screens,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (index) => bottomNavController.changeIndex(index),
            currentIndex: bottomNavController.selectedIndex.value,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.meeting_room_outlined), label: 'Meet'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), label: 'Learning'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          )),
    );
  }
}
