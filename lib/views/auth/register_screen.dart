import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/widgets/flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  bool loading = false;
  var isobscure1;
  var isobscure2;
  
  void saveTokenToDatabase() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final token = await FirebaseMessaging.instance.getToken();

  if (currentUser != null && token != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({'fcmToken': token});
  }
}

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  void initState() {
    isobscure1 = true;
    isobscure2 = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(BootstrapIcons.arrow_left, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Text(
                  'Sign up with Email',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.h,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Get chatting with friends and family today by signing up for our chat app!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF797C7B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.43.h,
                    letterSpacing: 0.10.sp,
                  ),
                ),
                SizedBox(height: 60.h),
                TextFormField( textInputAction: TextInputAction.next,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: namecontroller,
                  decoration: InputDecoration(
                    label: Text(
                      'Your name',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5EBAAE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.h,
                        letterSpacing: 0.10.sp,
                      ),
                    ),
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Enter your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                TextFormField( textInputAction: TextInputAction.next,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    label: Text(
                      'Your email',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5EBAAE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.h,
                        letterSpacing: 0.10.sp,
                      ),
                    ),
                  ),
                  validator: (email) {
                    if (email!.isEmpty ||
                        !RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(email)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                TextFormField( textInputAction: TextInputAction.next,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    label: Text(
                      'Password',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5EBAAE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.h,
                        letterSpacing: 0.10.sp,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isobscure1 = !isobscure1;
                        });
                      },
                      icon:
                          isobscure1
                              ? Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.white,
                                size: 20,
                              )
                              : Icon(
                                Icons.visibility_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                    ),
                  ),
                  obscureText: isobscure1,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                TextFormField( textInputAction: TextInputAction.done,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: confirmpasswordcontroller,
                  decoration: InputDecoration(
                    label: Text(
                      'Confirm Password',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5EBAAE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.h,
                        letterSpacing: 0.10.sp,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isobscure2 = !isobscure2;
                        });
                      },
                      icon:
                          isobscure2
                              ? Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.white,
                                size: 20,
                              )
                              : Icon(
                                Icons.visibility_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                    ),
                  ),
                  obscureText: isobscure2,
                  validator: (conformpassword) {
                    if (conformpassword!.isEmpty ||
                        passwordcontroller == confirmpasswordcontroller) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 121.h),
                InkWell(
                  onTap: ()async {
                      final provider = Provider.of<Authprovider>(
                      context,
                      listen: false,
                    );
                    bool success = await provider.register(
                      emailcontroller.text.trim(),
                      passwordcontroller.text.trim(),
                      namecontroller.text.trim()
                    );

                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      if (success) {
                        Navigator.pushReplacementNamed(context, "/home");
                        saveTokenToDatabase();
                        ToastMessage().toastmessage(message: "Success");
                        setState(() {
                          loading = false;
                        });
                      } else {
                        ToastMessage().toastmessage(message: "Login Failed");
                      }
                    }
                  },
                  child: Container(
                    width: 327.w,
                    height: 48.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF232929),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child:
                          loading
                              ? CircularProgressIndicator()
                              : Text(
                                'Create an account',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF797C7B),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.h,
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
