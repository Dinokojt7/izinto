// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:timer_count_down/timer_count_down.dart';
//
// import '../../../controllers/auth/countdown_controller.dart';
// import '../../../utils/colors.dart';
// import '../../../utils/dimensions.dart';
//
// class OtpView extends StatelessWidget {
//   const OtpView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = CountdownController();
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(
//               () => PinFieldAutoFill(
//                 textInputAction: TextInputAction.done,
//                 decoration: UnderlineDecoration(
//                     textStyle: TextStyle(
//                         fontSize: Dimensions.font16,
//                         color: AppColors.paraColor),
//                     colorBuilder: const FixedColorBuilder(Colors.transparent),
//                     bgColorBuilder: FixedColorBuilder(
//                       Colors.grey.withOpacity(0.2),
//                     )),
//                 onCodeSubmitted: (code) {},
//                 controller: controller.textEditingController,
//                 currentCode: controller.messageOtpCode.value,
//                 onCodeChanged: (code) {
//                   controller.messageOtpCode.value = code!;
//                   controller.countdownController.dispose();
//                 },
//               ),
//             ),
//             SizedBox(
//               height: Dimensions.height20,
//             ),
//             Countdown(
//               seconds: 15,
//               build: (context, currentRemainingTime) {
//                 return GestureDetector(
//                   onTap: currentRemainingTime != 0.0 ? () {} : () {},
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(Dimensions.height15),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(Dimensions.radius15),
//                       ),
//                       border: Border.all(
//                           color: AppColors.buttonBackgroundColor, width: 1),
//                       color: AppColors.mainColor2,
//                     ),
//                     width: context.width,
//                     child: Text(
//                       currentRemainingTime == 0.0
//                           ? 'Resend OTP'
//                           : currentRemainingTime.toString().length == 4 ? currentRemainingTime.toString().substring(0, 1) : currentRemainingTime.toString(),
//                     ),
//                   ),
//                 );
//               },
//               interval: const Duration(milliseconds: 1000),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
