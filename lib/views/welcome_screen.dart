import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.2,
          colors: [
            Color(0xFF3B0A54), // Purple glow center
            Colors.black, // Fades into black
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  Center(
                    child: SizedBox(
                      height: 19.20.h,
                      width: 87.w,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image(image: AssetImage("assets/images/Logo2.png")),
                              SizedBox(width: 6.h),
                              Text(
                                'Chatbox',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.h,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 43.8.h),
                  SizedBox(
                    width: 338,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Connect friends',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 68.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.25.h,
                            ),
                          ),
              
                          TextSpan(
                            text: ' easily & quickly',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 68.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.25.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'Our chat app is the perfect way to stay connected with friends and family.',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFB9C1BE),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.62.h,
                    ),
                  ),
                  SizedBox(height: 70.h),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: Container(
                      width: 327.w,
                      height: 48.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Sign up withn mail',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF000D07),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 46.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Existing account?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFB8C1BD),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.h,
                          letterSpacing: 0.10.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          ' Log in',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.h,
                            letterSpacing: 0.10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
