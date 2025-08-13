import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parttime/screens/host%20pages/details_page.dart';
import 'package:parttime/screens/host%20pages/host-registration-page.dart';
import 'package:parttime/screens/host%20pages/host_dash';
import 'package:parttime/screens/host%20pages/payment_page_1.dart';
import 'package:parttime/screens/host%20pages/payment_page_2';
import 'package:parttime/screens/host%20pages/payment_reciept.dart';
import 'package:parttime/screens/login_screen.dart';
import 'package:parttime/screens/worker%20pages/user_home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          home: PaymentSuccessPage(
            eventName: 'Sample Event', // Added required argument
            eventDate: '2023-10-01',
            eventImage: 'assets/event_image.png',
          ),
          debugShowCheckedModeBanner: false,
          color: Colors.white,
        );
      },
    );
  }
}
