import 'package:communityapp/firebase_options.dart';
import 'package:communityapp/models/message_model.dart';
import 'package:communityapp/models/user_model.dart';
import 'package:communityapp/views/auth/login_view.dart';

import 'package:communityapp/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(HiveMessageAdapter());
  Hive.registerAdapter(HiveUserAdapter());
  runApp(const GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Get the media query size
        final mediaQueryData = MediaQuery.of(context);
        final designSize =
            mediaQueryData.size.width > mediaQueryData.size.height
                ? const Size(955, 430)
                : const Size(430, 955);

        // Initialize ScreenUtil with the correct design size
        ScreenUtil.init(
          context,
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
        );

        return child!;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_auth.currentUser == null) {
        Get.off(() => const LoginView());
      } else {
        Get.off(() => MainView(userid: _auth.currentUser!.uid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Image.asset("assets/images/logo.jpg"),
            const SizedBox(width: 20),
            const Text(
              "Hackslash",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
