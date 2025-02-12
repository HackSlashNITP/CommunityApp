import 'package:communityapp/utils/logging.dart';
import 'package:communityapp/views/auth/login_view.dart';
import 'package:communityapp/views/profile/account_settings_view.dart';
import 'package:communityapp/views/profile/help_desk_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/profile_widgets.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  final String username;

  const ProfileView({super.key, required this.username});

  @override
  State<ProfileView> createState() => _StateProfileView();
}

class _StateProfileView extends State<ProfileView> {
  late String userEmail;
  late final ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ProfileController(widget.username));

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userEmail = user.email ?? 'No email available';
        });
      }
    });
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginView());
    } catch (e) {
      Logging.log.e("Error during logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final userData = _controller.userData.value;

        if (userData == null) {
          return Center(child: Text('No user data available.'));
        }

        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isPortrait
                    ? _buildPortraitLayout(userData)
                    : _buildLandscapeLayout(userData),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPortraitLayout(userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 5),
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundImage: NetworkImage(userData.avatarlink),
                  onBackgroundImageError: (_, __) => Icon(Icons.person,
                      size: MediaQuery.of(context).size.width * 0.10),
                ),
              ),
              SizedBox(height: 10),
              Text(
                userData.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),

        //Personal Information Section
        Row(
          children: [
            Text('Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Get.to(() => EditProfilePage()),
            ),
            Text('Edit'),
          ],
        ),
        ProfileInfoTile(
          title: 'Email',
          value: userEmail,
          leading: Icon(Icons.email),
        ),
        SizedBox(height: 10),
        ProfileInfoTile(
          title: 'Phone',
          value: '',
          leading: Icon(Icons.phone_android),
        ),
        SizedBox(height: 10),
        ProfileInfoTile(
          title: 'Linkedin',
          value: userData.linkedin ?? 'Not Provided',
          leading: Icon(Icons.account_circle),
        ),
        SizedBox(height: 10),
        ProfileInfoTile(
          title: 'Github',
          value: userData.github ?? 'Not Provided',
          leading: Icon(Icons.device_hub),
        ),
        SizedBox(height: 20),

        // Utilities Section
        Text('Utilities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ProfileInfoTile(
          title: 'Account Settings',
          value: '',
          leading: Icon(Icons.perm_identity),
          onPressed: () => Get.to(() => AccountSettings()),
        ),
        SizedBox(height: 10),
        ProfileInfoTile(
          title: 'Help Desk',
          value: '',
          leading: Icon(Icons.question_mark),
          onPressed: () => Get.to(() => HelpDesk()),
        ),
        SizedBox(height: 10),
        ProfileInfoTile(
          title: 'Logout',
          value: '',
          leading: Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLandscapeLayout(userData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 5),
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.10,
                  backgroundImage: NetworkImage(userData.avatarlink),
                  onBackgroundImageError: (_, __) => Icon(Icons.person,
                      size: MediaQuery.of(context).size.width * 0.10),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Information Section
              Row(
                children: [
                  Text('Personal Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Get.to(() => EditProfilePage()),
                  ),
                  Text('Edit'),
                ],
              ),
              ProfileInfoTile(
                title: 'Email',
                value: userEmail,
                leading: Icon(Icons.email),
              ),
              SizedBox(height: 10),
              ProfileInfoTile(
                title: 'Phone',
                value: '',
                leading: Icon(Icons.phone_android),
              ),
              SizedBox(height: 10),
              ProfileInfoTile(
                title: 'Linkedin',
                value: userData.linkedin ?? 'Not Provided',
                leading: Icon(Icons.account_circle),
              ),
              SizedBox(height: 10),
              ProfileInfoTile(
                title: 'Github',
                value: userData.github ?? 'Not Provided',
                leading: Icon(Icons.device_hub),
              ),
              SizedBox(height: 20),

              // Utilities Section
              Text('Utilities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ProfileInfoTile(
                title: 'Account Settings',
                value: '',
                leading: Icon(Icons.perm_identity),
                onPressed: () => Get.to(() => AccountSettings()),
              ),
              SizedBox(height: 10),
              ProfileInfoTile(
                title: 'Help Desk',
                value: '',
                leading: Icon(Icons.question_mark),
                onPressed: () => Get.to(() => HelpDesk()),
              ),
              SizedBox(height: 10),
              ProfileInfoTile(
                title: 'Logout',
                value: '',
                leading: Icon(Icons.logout),
                onPressed: () => _logout(context),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
