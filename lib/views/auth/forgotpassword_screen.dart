import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  bool loading = false;
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

                SizedBox(height: 173.h),
                InkWell(
                  onTap: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    setState(() {
                      loading = true;
                    });

                    try {
                      await Provider.of<Authprovider>(
                        context,
                        listen: false,
                      ).forgotPassword(emailcontroller.text.trim());

                      Navigator.pop(context);
                      ToastMessage().toastmessage(
                        message: "Reset link sent to your email",
                      );
                    } catch (e) {
                      ToastMessage().toastmessage(
                        message: "Reset failed: ${e.toString()}",
                      );
                    } finally {
                      setState(() {
                        loading = false;
                      });
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
                                'Reset Password',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
