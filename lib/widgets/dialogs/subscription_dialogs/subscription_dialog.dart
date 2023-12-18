import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../base/transition.dart';
import '../../../models/user.dart';
import '../../../pages/options/settings_view/terms_of_use.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../miscellaneous/app_icon.dart';
import '../../texts/integers_and_doubles.dart';
import '../../texts/small_text.dart';

class showSubscriptionSignUp extends StatefulWidget {
  const showSubscriptionSignUp({Key? key, required this.showDialog})
      : super(key: key);

  final ValueNotifier<bool> showDialog;

  @override
  State<showSubscriptionSignUp> createState() => _showSubscriptionSignUpState();
}

class _showSubscriptionSignUpState extends State<showSubscriptionSignUp> {
  final isShowLoader = ValueNotifier<bool>(true);
  final bool isLoadingPayment = false;
  int currentSubscriptionOffer = 650;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      setState(() {
        isShowLoader.value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isShowLoader,
        builder: (context, value, _) {
          return Dialog(
            backgroundColor: Colors.black38,
            insetPadding: EdgeInsets.all(0),
            elevation: 0,
            child: DefaultTextStyle(
              style: TextStyle(decoration: TextDecoration.none),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: isShowLoader.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    : Center(
                        child: Container(
                          height: Dimensions.screenHeight / 1.5,
                          width: Dimensions.screenWidth / 1.08,
                          margin:
                              EdgeInsets.only(top: Dimensions.screenHeight / 8),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.5,
                                offset: Offset(1, 1),
                              ),
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.5,
                                offset: Offset(1, -1),
                              ),
                            ],
                            color: Colors.white,
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  'assets/image/subscription_display.jpeg'),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(Dimensions.width10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          widget.showDialog.value =
                                              !widget.showDialog.value;
                                        },
                                        child: AppIcon(
                                          backgroundColor: Colors.white,
                                          weight: 20,
                                          size: 30,
                                          icon: Icons.close,
                                          iconColor: Color(0Xff353839),
                                          iconSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: Dimensions.height20.toInt(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IntegerText(
                                      text: 'LAUNDRY',
                                      size: Dimensions.font16 * 2,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IntegerText(
                                      text: 'Subscription',
                                      height: Dimensions.height20 /
                                          Dimensions.height20,
                                      size: Dimensions.font16 * 2.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(
                                flex: Dimensions.height15 ~/ 2,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10),
                                  child: IntegerText(
                                    align: TextAlign.center,
                                    text:
                                        'Wash a minimum of 5kg laundry per week!',
                                    size: Dimensions.font16 * 1.4,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mainBlackColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: Dimensions.bottomHeightBar / 1.1,
                                width: Dimensions.screenWidth,
                                padding: EdgeInsets.only(
                                    top: Dimensions.height10 / 2,
                                    bottom: Dimensions.height10 / 2,
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        Dimensions.radius20 * 2),
                                    topRight: Radius.circular(
                                        Dimensions.radius20 * 2),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height20 / 1.5,
                                        bottom: Dimensions.height20 / 1.5,
                                        left: Dimensions.width20,
                                        right: Dimensions.width20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IntegerText(
                                              text:
                                                  'R$currentSubscriptionOffer',
                                              size: Dimensions.font16 * 1.06,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.mainBlackColor,
                                            ),
                                            SmallText(
                                              text: 'Billed quarterly',
                                              size: Dimensions.font16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.mainBlackColor,
                                            ),
                                          ],
                                        ),
                                        isLoadingPayment
                                            ? Container(
                                                height:
                                                    Dimensions.screenHeight /
                                                        15,
                                                width: Dimensions.screenWidth /
                                                    2.6,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      AppColors.six,
                                                      Color(0xff9A9483),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        Dimensions.radius20 *
                                                            3),
                                                  ),
                                                ),
                                                child: Transform.scale(
                                                  scale: 0.5,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 3,
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ))
                                            : SubscribeNowButton(
                                                text: 'Subscribe now',
                                                amount:
                                                    currentSubscriptionOffer,
                                                isShowLoader: isShowLoader,
                                              )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color:
                                          AppColors.fontColor.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => const TermsOfUse(),
                                            duration:
                                                Duration(milliseconds: 100));
                                      },
                                      child: IntegerText(
                                        text: 'Terms & Conditions',
                                        size: Dimensions.font16 / 1.2,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          );
        });
  }
}

class SubscribeNowButton extends StatefulWidget {
  const SubscribeNowButton({
    super.key,
    required this.text,
    required this.amount,
    required this.isShowLoader,
  });

  final String text;
  final int amount;
  final ValueNotifier<bool> isShowLoader;

  @override
  State<SubscribeNowButton> createState() => _SubscribeNowButtonState();
}

class _SubscribeNowButtonState extends State<SubscribeNowButton> {
  String publicKeyTest =
      'pk_test_f5c4e5da2cab8e6662f6cf695f4b1b2b649b8814'; //pass in the public test key here
  final plugin = PaystackPlugin();
  @override
  void initState() {
    plugin.initialize(publicKey: publicKeyTest);
    super.initState();
  }

  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    // Future<void> initPaymentSheet(context,
    //     {required String uid, required int amount}) async {
    //   try {
    //     final response = await http.post(Uri.parse('uri'),
    //         body: {'uid': uid, 'amount': amount.toString()});
    //
    //     final jsonResponse = jsonDecode(response.body);
    //     log(jsonResponse.toString());
    //
    //     /// initialise the payment sheet ///
    //     await Stripe.instance.initPaymentSheet(
    //         paymentSheetParameters: SetupPaymentSheetParameters(
    //       paymentIntentClientSecret: jsonResponse['paymentIntent'],
    //       merchantDisplayName: 'Izinto On-demand',
    //       customerId: jsonResponse['customer'],
    //       customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
    //       style: ThemeMode.light,
    //       // testEnv:true,
    //     ));
    //     await Stripe.instance.presentPaymentSheet();
    //     Get.snackbar(
    //       '',
    //       'You\'ve successfully subscribed to a premium laundry service.',
    //       backgroundColor: AppColors.six.withOpacity(0.2),
    //       borderColor: AppColors.six,
    //       // colorText: Colors.white
    //     );
    //   } catch (e) {
    //     if (e is StripeException) {
    //       Get.snackbar(
    //         'Error',
    //         '${e.error.localizedMessage}',
    //         backgroundColor: AppColors.six.withOpacity(0.2),
    //         borderColor: AppColors.six,
    //         // colorText: Colors.white
    //       );
    //     } else {
    //       Get.snackbar(
    //         'Error',
    //         '${e}',
    //         backgroundColor: AppColors.six.withOpacity(0.2),
    //         borderColor: AppColors.six,
    //         // colorText: Colors.white
    //       );
    //     }
    //   }
    // }

    Future<void> chargeCard(context, {required int amount}) async {
      try {
        var charge = Charge()
          ..amount = amount *
              100 //the money should be in kobo hence the need to multiply the value by 100
          ..reference = _getReference()
          ..putCustomField('custom_id',
              '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
          ..email = 'tutorial@email.com';
        CheckoutResponse response = await plugin.checkout(
          context,
          method: CheckoutMethod.card,
          charge: charge,
        );
        await response;
        // Get.snackbar(
        //   '',
        //   'You\'ve successfully subscribed to a premium laundry service.',
        //   backgroundColor: AppColors.six.withOpacity(0.2),
        //   borderColor: AppColors.six,
        //   // colorText: Colors.white
        // );
      } catch (e) {
        Get.snackbar(
          'Error',
          '',
          backgroundColor: AppColors.six.withOpacity(0.2),
          borderColor: AppColors.six,
          // colorText: Colors.white
        );
      }
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              widget.isShowLoader.value = !widget.isShowLoader.value;
            });
            //   Future.delayed(const Duration(seconds: 2), () async {
            //   setState(() {
            //     isShowLoader = false;
            //   });
            // });
            await chargeCard(context, amount: widget.amount * 100);
          },
          child: Container(
            height: Dimensions.screenHeight / 15,
            width: Dimensions.screenWidth / 2.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.six,
                  Color(0xff9A9483),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.radius20 * 3),
              ),
            ),
            child: Center(
              child: SmallText(
                text: widget.text,
                size: Dimensions.font16 * 1.06,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
