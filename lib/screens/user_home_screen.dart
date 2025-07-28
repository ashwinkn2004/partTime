import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:parttime/screens/profile_screen.dart';

final profileActiveProvider = StateProvider<bool>((ref) => true);

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProfileActive = ref.watch(profileActiveProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0, // Set elevation to 0 to prevent shadow
        scrolledUnderElevation:
            0, // Set scrolledUnderElevation to 0 to prevent elevation change on scroll
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              icon: Icon(LucideIcons.bell, size: 24.sp, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0.03.sh),

            // Profile Section
            Center(
              child: SizedBox(
                height: 128.h,
                width: 358.w,
                child: Row(
                  children: [
                    Container(
                      width: 128.w,
                      height: 128.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Image.asset('assets/images/profile.png'),
                      ),
                    ),
                    SizedBox(width: 0.05.sw),
                    Container(
                      width: 189.w,
                      height: 128.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ethan Carter',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Event Staff\nJoined Jan 2023\n4.8☆',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Inter',
                              color: const Color(0xFF947854),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 0.04.sh),

            // Toggle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Activate Profile",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF947854),
                    ),
                  ),
                  FlutterSwitch(
                    width: 53.w,
                    height: 32.h,
                    toggleSize: 26.r,
                    value: isProfileActive,
                    padding: 3,
                    activeColor: const Color(0xFFE6BD82),
                    inactiveColor: const Color(0xFFE6BD82),
                    toggleColor: const Color(0xFF947854),
                    onToggle: (val) {
                      ref.read(profileActiveProvider.notifier).state = val;
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Stats
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  _statCard("120", "Hours Worked"),
                  SizedBox(width: 16.w),
                  _statCard("2", "Black Marks"),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Manage Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manage",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: _roundedButton("Profile"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: _roundedButton("Settings"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Upcoming Events
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

            _eventCard(
              status: "Confirmed",
              title: "Tech Conference",
              subtitle: "Event Staff · 10:00 AM - 6:00 PM",
              imagePath: "assets/images/sample.png",
            ),

            // Work History
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Work History",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

            _eventCard(
              status: "Completed",
              title: "Music Festival",
              subtitle: "Event Staff · 12:00 PM - 10:00 PM",
              imagePath: "assets/images/sample.png",
            ),
            _eventCard(
              status: "Completed",
              title: "Sports Event",
              subtitle: "Event Staff · 9:00 AM - 5:00 PM",
              imagePath: "assets/images/sample.png",
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // Stat Card Widget
  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.black12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF947854),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Manage Button Widget
  Widget _roundedButton(String label) {
    return Container(
      width: 90.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE6BD82),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Event Card Widget
  Widget _eventCard({
    required String status,
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 150.h,
        child: Row(
          children: [
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: const Color(0xFF947854),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF947854),
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 32.h,
                    width: 84.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2ECE4),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        "View",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                imagePath,
                height: 90.h,
                width: 90.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
