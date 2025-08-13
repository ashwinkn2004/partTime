import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),

            // Profile Image
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                height: 100.h,
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),

            // Name & Rating
            Text(
              'Sophia Carter',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '4.8 ⭐ • San Francisco, CA',
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Inter',
                color: const Color(0xFF947854),
              ),
            ),
            SizedBox(height: 20.h),

            // Edit Button
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE6BD82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Verification Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verification',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.verified_user_outlined, color: Colors.black),
                SizedBox(width: 8.w),
                Text(
                  'Verified',
                  style: TextStyle(fontFamily: 'Inter', fontSize: 16.sp),
                ),
                const Spacer(),
                const Icon(Icons.check, color: Colors.black),
              ],
            ),
            SizedBox(height: 30.h),

            // Work & Skills Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Work & Skills',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _workItem(title: 'Hours Worked', value: '120'),
                _workItem(title: 'Events Completed', value: '30'),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _workItem(title: 'Preferred', value: 'Bartender,\nServer'),
                _workItem(title: 'Skills', value: 'Mixology, Customer Service'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _workItem({required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
