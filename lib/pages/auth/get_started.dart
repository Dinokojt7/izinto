import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth/auth_provider.dart';
import '../../controllers/auth/countdown_controller.dart';
import '../../controllers/auth/phone_auth/otp_screen.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../services/firebase_auth_methods.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/main_buttons/login_button.dart';
import '../../widgets/main_buttons/phone_auth_button.dart';
import '../../widgets/texts/app_text_field.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  static String verify = '';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var phoneController = TextEditingController();

  phoneSignIn() async {
    try {
      final user = await FirebaseAuthMethods()
          .phoneAuthLogin(context, '+27${phoneController.text}')
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user.uid)
            .set({'phoneNumber': value.user.phoneController.text});
      });
      if (user != null) {
        print('We have a user and token');
        Get.toNamed(RouteHelper.getInitial());
      }
    } catch (e) {
      print(e);
    }
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signIinWithPhone(context, phoneNumber);
  }

  // Future<dynamic> _signUpWithPhone(){
  //   FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneController.text.trim(),
  //       verificationCompleted:
  //           (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {},
  //       codeSent:
  //           (String verificationId, int? resendToken) {},
  //       codeAutoRetrievalTimeout:
  //           (String verificationId) {});
  //
  //   return user;
  // }

  @override
  Widget build(BuildContext context) {
    void validateAndModifyPhone(String phone) {
      if (phone.isEmpty || phone == 'Phone') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Phone number is required'),
          ),
        );
      } else if (phone.startsWith('+27')) {
        // Already has country code, do nothing
        if (phone.length > 12 || phone.length < 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid phone number format'),
            ),
          );
        } else {
          setState(() {
            isLoading = true;
          });
        }
      } else if (phone.startsWith('0')) {
        // Modify phone with country code
        if (phone.length > 12 || phone.length < 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid phone number format'),
            ),
          );
        } else {
          phoneController.text = '+27' + phone.substring(1);
          setState(() {
            isLoading = true;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid phone number format'),
          ),
        );
      }
    }

    double logicalPixels = 640.0;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isSmallestDevice = screenHeight <= logicalPixels;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Image(
          image: AssetImage('assets/image/asset.png'),
          height: Dimensions.height20 * 2,
        ),
        iconTheme: IconThemeData(color: AppColors.mainBlackColor, size: 30),
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<AuthController>(builder: (_authController) {
        return Stack(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.screenHeight * 0.03),

                    //Main text fields
                    //phone
                    Container(
                      height: Dimensions.screenHeight / 14,
                      width: Dimensions.width30 * 12 + 5,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.screenHeight / 70),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius15)),
                      ),
                      child: TextFormField(
                        controller: phoneController,
                        validator: (val) {
                          validateAndModifyPhone(val!);
                          return null; // Validation will be done via the Snackbar
                        },
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        cursorColor: Color(0xff9A9483),
                        decoration: InputDecoration(
                          labelText: 'Phone',

                          floatingLabelStyle: TextStyle(
                            color: AppColors.fontColor,
                          ),
                          contentPadding: EdgeInsets.only(bottom: 2, left: 20),

                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter number',
                          hintStyle: TextStyle(
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColor,
                          ),

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius15),
                              ),
                              borderSide: const BorderSide(
                                width: 1.0,
                                color: Color(0xff9A9483),
                              )),
                          //enabled border
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius15),
                            ),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          //border
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'We\'ll send OTP to this number for verification',
                        style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: Dimensions.font16 - 1),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),

                    //name

                    //phone
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height45),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        //  await _signUpWithPhone();
                        await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phoneController.text.trim(),
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              GetStarted.verify = verificationId;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    phone: phoneController.text.trim(),
                                    verificationId: verificationId,
                                  ),
                                ),
                              );
                              setState(() {
                                isLoading = false;
                              });
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {});
                      }
                    },
                    child: PhoneAuthButton(
                      phoneController: phoneController,
                      isLoading: isLoading,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
