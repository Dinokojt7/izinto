import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../services/firebase_auth_methods.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class BottomDeleteSheet extends StatefulWidget {
  final String expected;
  final String headerText;
  final String action;
  final int? index;

  const BottomDeleteSheet({
    Key? key,
    required this.expected,
    required this.headerText,
    required this.action,
    this.index,
  }) : super(key: key);

  @override
  State<BottomDeleteSheet> createState() => _BottomDeleteSheetState();
}

class _BottomDeleteSheetState extends State<BottomDeleteSheet> {
  bool _isLoading = false;

  //LOGOUT
  deleteSession() async {
    setState(() {
      _isLoading = true;
    });

    Get.find<CartController>().clear();
    Get.find<CartController>().clearCartHistory();

    Future.delayed(const Duration(seconds: 3), () async {
      await FirebaseAuthMethods().signOut(context);
      setState(() {
        Navigator.of(context).pop();
      });
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  //REMOVE INDIVIDUAL ITEM FROM CART
  removeItem() async {
    final cart = await Get.find<CartController>();

    setState(() {
      cart.addItem(cart.getItems[widget.index!].specialty!, -1);
      Navigator.of(context).pop();
    });
  }

  //BULK DELETE ITEMS IN CART
  clearCart() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
        Get.find<CartController>().clear();
        Get.find<CartController>().clearCartHistory();
        Navigator.of(context).pop();
      });
    });
  }

  applySubscription(int? totalDiscountedAmount) async {}

  //DELETE USER ACCOUNT
  deleteAccount() async {
    setState(() {
      _isLoading = true;
    });

    Get.find<CartController>().clear();

    Future.delayed(const Duration(seconds: 3), () async {
      setState(() {
        Navigator.of(context).pop();
      });
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.width30),
                width: double.infinity,
                height: Dimensions.screenHeight / 4.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: Colors.white),
                padding: EdgeInsets.fromLTRB(
                    Dimensions.width20, 0, Dimensions.width20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.headerText,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontFamily: 'Hind',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    const Divider(
                      indent: 8,
                      endIndent: 8,
                      color: Colors.black26,
                      height: 20,
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.expected == 'Logout') {
                              deleteSession();
                            } else if (widget.expected == 'Delete account') {
                              deleteAccount();
                            } else if (widget.expected == 'Remove item') {
                              removeItem();
                            } else if (widget.expected == 'Clear cart') {
                              clearCart();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.only(
                                left: Dimensions.width20 * 1.2,
                                right: Dimensions.width15 * 1.2),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(2, 2),
                                    color: AppColors.mainBlackColor
                                        .withOpacity(0.01),
                                  ),
                                  BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color:
                                        AppColors.iconColor1.withOpacity(0.01),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                border: Border.all(
                                    width: 1,
                                    color: const Color(0xffB09B71)
                                        .withOpacity(0.4)),
                                color: Colors.transparent),
                            child: _isLoading
                                ? Transform.scale(
                                    scale: 0.5,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.5,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      top: Dimensions.height20 / 1.8,
                                      bottom: Dimensions.height20 / 1.8,
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.action,
                                        style: TextStyle(
                                          fontSize: Dimensions.font26 / 1.4,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
