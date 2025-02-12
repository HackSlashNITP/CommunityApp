import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthComponents {
  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required bool isPortrait,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 360),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: isPortrait ? 16.sp : 10.sp),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Icon(prefixIcon,
                color: const Color.fromARGB(255, 65, 189, 115),
                size: isPortrait ? 24.r : 20.r),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required bool isPortrait,
    required RxBool obscureText,
    required VoidCallback toggleObscureText,
  }) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 360),
        child: Obx(
          () => TextField(
            controller: controller,
            obscureText: obscureText.value,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: isPortrait ? 16.sp : 10.sp),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Icon(
                  CupertinoIcons.lock,
                  color: const Color.fromARGB(255, 65, 189, 115),
                  size: isPortrait ? 24.r : 20.r,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: toggleObscureText,
                icon: Obx(() => Icon(
                      obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(255, 174, 179, 176),
                      size: isPortrait ? 24.r : 20.r,
                    )),
              ),
            ),
          ),
        ));
  }

  Widget buildActionText(
      String prefix, String text, VoidCallback onTap, bool isPortrait) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: prefix,
              style: TextStyle(
                  fontSize: isPortrait ? 14.sp : 10.sp,
                  color: Colors.grey[400])),
          TextSpan(
            text: text,
            style: TextStyle(
                fontSize: isPortrait ? 14.sp : 10.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 65, 189, 115)),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }

  Widget buildbtn(String text, RxBool isLoading, bool isPortrait,
      void Function() function) {
    return Obx(
      () => ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 65, 189, 115),
        ),
        child: isLoading.value
            ? SizedBox(
                height: 16.sp,
                width: 16.sp,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isPortrait ? 16.sp : 12.sp)),
      ),
    );
  }

  List<Widget> buildLogo(bool isPortrait) {
    return <Widget>[
      Text("Welcome To",
          style: TextStyle(fontSize: 16.sp, color: Colors.white)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.jpg",
              fit: BoxFit.cover,
              height: isPortrait ? 48.h : 48.w,
              width: isPortrait ? 48.h : 48.w),
          SizedBox(width: 16.h),
          Text("Hackslash",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40.sp,
                  color: Colors.white)),
        ],
      ),
    ];
  }
}
