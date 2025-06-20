import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/widgets/flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var isobscure;
  bool loading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final formKey = GlobalKey<FormState>();
  Future<void> signinwithgoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
        ToastMessage().toastmessage(message: 'succusfully completed');
      }
    } catch (e) {
      ToastMessage().toastmessage(message: e.toString());
    }
  }
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
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isobscure = true;
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
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Text(
                  'Log in to Chatbox',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.h,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Welcome back! Sign in using your social account or email to continue us',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF797C7B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.43.h,
                    letterSpacing: 0.10.sp,
                  ),
                ),
                SizedBox(height: 32.h),
                InkWell(
                  onTap: () {
                    signinwithgoogle();
                  },
                  child: Container(
                    width: 280.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/google.png"),
                          height: 20.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Sign up with Google',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF000D07),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: 315,
                  height: 14,
                  child: Row(
                    children: [
                      Opacity(
                        opacity: 1,
                        child: Container(
                          width: 132,
                          height: 0.1,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: const Color.fromARGB(255, 145, 148, 147),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF797C7B),
                          fontSize: 14.sp,

                          fontWeight: FontWeight.w500,
                          height: 1,
                          letterSpacing: 0.10,
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Opacity(
                        opacity: 1,
                        child: Container(
                          width: 132,
                          height: 0.1,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: const Color.fromARGB(255, 145, 148, 147),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                TextFormField(
                  textInputAction: TextInputAction.next,
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
                TextFormField(
                  textInputAction: TextInputAction.done,
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
                          isobscure = !isobscure;
                        });
                      },
                      icon:
                          isobscure
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
                  obscureText: isobscure,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 173.h),
                InkWell(
                  onTap: () async {
                    final provider = Provider.of<Authprovider>(
                      context,
                      listen: false,
                    );
                    bool success = await provider.login(
                      emailcontroller.text.trim(),
                      passwordcontroller.text.trim(),
                    );

                    if (formKey.currentState!.validate()) {
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
                      color: Color(0xFF24786D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child:
                          loading
                              ? CircularProgressIndicator()
                              : Text(
                                'Log in',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.h,
                                ),
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/forgot");
                  },
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5EBAAE),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.h,
                      letterSpacing: 0.10.sp,
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
