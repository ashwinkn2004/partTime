import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:parttime/controller/auth_controller.dart';
import 'package:parttime/screens/user_home_screen.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final obscure = ref.watch(obscureTextProvider);
    final authController = ref.watch(loginControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back),
              ),
              SizedBox(height: 0.10.sh),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE5BD82),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              // Email Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  onChanged: (val) =>
                      ref.read(emailProvider.notifier).state = val,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Username or Email',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF737373),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Password Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  obscureText: obscure,
                  onChanged: (val) =>
                      ref.read(passwordProvider.notifier).state = val,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF737373),
                      fontFamily: 'Inter',
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? LucideIcons.eyeOff : LucideIcons.eye,
                        color: Colors.grey,
                        size: 20.h,
                      ),
                      onPressed: () {
                        ref.read(obscureTextProvider.notifier).state = !obscure;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      color: const Color(0xFF737373),
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Google Login
              /*Center(
                child: Column(
                  children: [
                    Text(
                      "Or Login with",
                      style: TextStyle(fontSize: 15.sp, fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 40.h,
                      width: 40.h,
                      child: ElevatedButton(
                        onPressed: () => authController.loginWithGoogle(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          elevation: 0,
                        ),
                        child: Image.asset('assets/icons/google.png'),
                      ),
                    ),
                  ],
                ),
              ),*/
              SizedBox(height: 30.h),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserHomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A3A3A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFFDDBB83),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to registration screen
                  },
                  child: Text(
                    "New user ? Register",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF3A3A3A),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
