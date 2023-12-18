import 'dart:math';
import 'package:Izinto/pages/cart/payment_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_specialty_controller.dart';
import '../../controllers/recommended_specialty_controller.dart';
import '../../models/user.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/dialogs/main_dialog.dart';
import '../../widgets/dialogs/subscription_dialogs/subscription_dialog.dart';
import '../../widgets/dialogs/token_display/token_status_dialog.dart';
import '../../widgets/miscellaneous/app_icon.dart';
import '../../widgets/subscription/subscription_in_cart/apply_sub.dart';
import '../../widgets/bottom_delete_sheet.dart';
import '../../widgets/subscription/subscription_in_cart/cart_sub_card.dart';
import '../../widgets/main_buttons/cart_checkout_button.dart';
import '../../widgets/texts/integers_and_doubles.dart';
import '../../widgets/texts/small_text.dart';
import '../../widgets/subscription/subscription_in_cart/sub_column_display.dart';
import '../home/wrapper.dart';
import '../options/settings_view/get_help_popup.dart';
import '../subscriptions/subscriptions.dart';
import '../auth/access.dart';
import '../auth/login.dart';
import 'bottom_bar_lever.dart';
import 'main_bottom_container.dart';
import 'no_items.dart';

class ReCart extends StatefulWidget {
  const ReCart({Key? key}) : super(key: key);

  @override
  State<ReCart> createState() => _ReCartState();
}

class _ReCartState extends State<ReCart> with SingleTickerProviderStateMixin {
  late final AnimationController _slideAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1250));
  late final Animation<Offset> _slideAnimation =
      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
          .animate(_slideAnimationController);
  @override
  void initState() {
    super.initState();
    _slideAnimationController.forward();
    _streamUserInfo = _referenceUserInfo.snapshots();
    _getSubscriptionStatus();
  }

  //Main parameters
  final status = ValueNotifier<int>(0);
  final washType = ValueNotifier<String>('');
  final lastDate = ValueNotifier<String>('');
  final nextDate = ValueNotifier<String>('');
  final discountedItems = ValueNotifier<int>(0);
  final discount = ValueNotifier<int>(0);
  int? totalOrderAmount;
  List cart = Get.find<CartController>().getItems;
  List chatRoom = [];
  final _isLoadingLog = ValueNotifier<bool>(false);
  // bool showSubscriptionDialog = false;
  final showSubscriptionDialog = ValueNotifier<bool>(false);
  ValueNotifier<bool> _switch = ValueNotifier<bool>(false);
  final _showSubscriptionSignUp = ValueNotifier<bool>(false);

  //From database
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference _referenceUserInfo =
      FirebaseFirestore.instance.collection('izinto');
  late Stream<QuerySnapshot> _streamUserInfo;
  String _userId = '';
  int _laundrySubscription = 0;
  int _carWashSubscription = 0;
  int _laundryItemCount = 0;
  int _laundryDiscount = 0;
  int _carWashItemCount = 0;
  int _carWashDiscount = 0;
  String _laundryLastDate = '04 November 23';
  String _laundryNextDate = '11 November 23';
  String _carWashLastDate = '30 November 23';
  String _carWashNextDate = '07 November 23';

  void _getSubscriptionStatus() async {
    User? user = await _firebaseAuth.currentUser;
    print('It\'s running');
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      if (mounted) print('Look look look this is running again');
      setState(() {
        _userId = user!.uid;
        _carWashSubscription = userData['carWashSubscription'] != null
            ? userData['carWashSubscription']
            : 0;
        _laundrySubscription = userData['laundrySubscription'] != null
            ? userData['laundrySubscription']
            : 0;
        _laundryLastDate = userData['laundryLastDate'] != null
            ? userData['laundryLastDate']
            : '';
        _laundryNextDate = userData['laundryActiveDate'] != null
            ? userData['laundryActiveDate']
            : '';
        _carWashLastDate = userData['carWashLastDate '] != null
            ? userData['carWashLastDate ']
            : '';
        _carWashNextDate = userData['carWashActiveDate'] != null
            ? userData['carWashActiveDate']
            : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return ValueListenableBuilder(
        valueListenable: showSubscriptionDialog,
        builder: (context, value, _) {
          return Stack(
            children: [
              Scaffold(
                  appBar: buildAppBar(context),
                  body: Stack(
                    children: [
                      //Cart items list
                      buildItemList(context),
                      buildTopRow(),
                    ],
                  ),
                  bottomNavigationBar: buildBottomNavigation()),
              _isLoadingLog.value ? LoadingIndicator() : Container(),
              showSubscriptionDialog.value
                  ? MainDialog(
                      contents: ValueListenableBuilder(
                          valueListenable: _showSubscriptionSignUp,
                          builder: (context, value, _) {
                            return ValueListenableBuilder(
                                valueListenable: status,
                                builder: (context, value, _) {
                                  return ValueListenableBuilder(
                                    valueListenable: washType,
                                    builder: (context, value, _) {
                                      return ValueListenableBuilder(
                                          valueListenable: lastDate,
                                          builder: (context, value, _) {
                                            return ValueListenableBuilder(
                                                valueListenable: nextDate,
                                                builder: (context, value, _) {
                                                  return ValueListenableBuilder(
                                                      valueListenable:
                                                          discountedItems,
                                                      builder:
                                                          (context, value, _) {
                                                        return ValueListenableBuilder(
                                                            valueListenable:
                                                                discount,
                                                            builder: (context,
                                                                value, _) {
                                                              return SubscriptionDialog(
                                                                subscriptionStatus:
                                                                    status
                                                                        .value,
                                                                laundryOffer:
                                                                    null,
                                                                lastDate:
                                                                    lastDate
                                                                        .value,
                                                                nextDate:
                                                                    nextDate
                                                                        .value,
                                                                carWashOffer:
                                                                    null,
                                                                washType:
                                                                    washType
                                                                        .value,
                                                                showDialog:
                                                                    showSubscriptionDialog,
                                                                itemCount:
                                                                    discountedItems
                                                                        .value,
                                                                discount:
                                                                    discount
                                                                        .value,
                                                                showSubscriptionSignUp:
                                                                    _showSubscriptionSignUp,
                                                              );
                                                            });
                                                      });
                                                });
                                          });
                                    },
                                  );
                                });
                          }),
                      height: Dimensions.screenHeight / 3,
                      width: Dimensions.screenWidth / 1.3,
                    )
                  : Container(),
              _showSubscriptionSignUp.value
                  ? showSubscriptionSignUp(
                      showDialog: _showSubscriptionSignUp,
                    )
                  : Container(),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _slideAnimationController.dispose();
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius30),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.six.withOpacity(0.5),
            Colors.white,
            Colors.white,
            Colors.white
          ]),
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
        image: AssetImage('assets/image/subscription_display.jpeg'),
      ),
    );
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  //////////////////SECTION DIVIDER////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  //Build items

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      iconTheme: IconThemeData(
          weight: 900,
          color: AppColors.fontColor,
          size: Dimensions.font20 * 1.5),
      titleTextStyle: TextStyle(
          fontSize: Dimensions.font20 * 1.5,
          color: AppColors.fontColor,
          fontWeight: FontWeight.w700),
      title: Text('Cart'),
      centerTitle: false,
      backgroundColor: Colors.white,
    );
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  GetBuilder<CartController> buildTopRow() {
    return GetBuilder<CartController>(builder: (_cartController) {
      final String quantityText =
          _cartController.totalItems == 1 ? 'item' : 'items';
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            alignment: Alignment.topCenter,
            color: Colors.white,
            width: Dimensions.screenWidth,
            height: Dimensions.bottomHeightBar / 3.3,
            child: _cartController.getItems.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IntegerText(
                        text: _cartController.totalItems.toString() +
                            ' ${quantityText}',
                        size: Dimensions.font16 / 1.1,
                        color: AppColors.fontColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.find<CartController>().clear();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _clearCart();
                              },
                              child: IntegerText(
                                height: 2,
                                text: 'Clear cart',
                                size: Dimensions.font16 / 1.2,
                                color: Color(0xffA0937D),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Stack(
                              children: [
                                Icon(
                                  MdiIcons.delete,
                                  size: 18,
                                  color: Color(0xffA0937D),
                                ),
                                Positioned(
                                  top: 4,
                                  left: 3,
                                  child: Icon(
                                    Icons.close_outlined,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Container(),
          ),
        ],
      );
    });
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  Padding buildItemList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height20),
      child: GetBuilder<CartController>(builder: (_cartController) {
        return _cartController.getItems.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: Container(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(
                        builder: (cartController) {
                          var _cartList = cartController.getItems;
                          return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.height30,
                                      bottom: Dimensions.height15 / 4),
                                  width: double.maxFinite,
                                  height: Dimensions.height20 * 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularSpecialtyController>()
                                              .popularSpecialtyList
                                              .indexOf(
                                                  _cartList[index].specialty!);

                                          Get.toNamed(
                                              RouteHelper.getPopularSpecialties(
                                                  popularIndex, 'cartpage'));

                                          var recommendedIndex = Get.find<
                                                  RecommendedSpecialtyController>()
                                              .recommendedSpecialtyList
                                              .indexOf(
                                                  _cartList[index].specialty!);

                                          Get.toNamed(RouteHelper
                                              .getRecommendedSpecialities(
                                                  recommendedIndex,
                                                  'cartpage'));
                                        },
                                        //Image Container
                                        child: Container(
                                          width: Dimensions.height20 * 3.5,
                                          height: Dimensions.height20 * 3.5,
                                          // margin: EdgeInsets.only(
                                          //     bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 1.0,
                                              )
                                            ],
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(cartController
                                                    .getItems[index].img!)),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        height: Dimensions.height20 * 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IntegerText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  size: Dimensions.font16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.mainColor2,
                                                ),
                                              ],
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions
                                                                .height20 /
                                                            1.3),
                                                    child: IntegerText(
                                                      text:
                                                          'R ${cartController.getItems[index].price!.toString()}.00',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black54,
                                                      size: Dimensions.font16,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10 /
                                                              2,
                                                      // left: Dimensions.width10,
                                                      // right:
                                                      //     Dimensions.width10
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (_cartList[
                                                                            index]
                                                                        .quantity ==
                                                                    1) {
                                                                  _confirmRemove(
                                                                      _cartList[
                                                                              index]
                                                                          .name!,
                                                                      index);
                                                                } else {
                                                                  cartController.addItem(
                                                                      _cartList[
                                                                              index]
                                                                          .specialty!,
                                                                      -1);
                                                                }
                                                              },
                                                              child: Container(
                                                                // padding: EdgeInsets.symmetric(
                                                                //   horizontal: Dimensions.width10,
                                                                //   vertical: Dimensions.height10 / 2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      width:
                                                                          1.5,
                                                                      color: Color(
                                                                          0xffA0937D)),
                                                                ),
                                                                child: AppIcon(
                                                                  weight: 10,
                                                                  size: 22,
                                                                  iconSize:
                                                                      Dimensions
                                                                          .iconSize24,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  iconColor: Color(
                                                                      0xffA0937D),
                                                                  icon: Icons
                                                                      .remove,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                  .width30,
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                  .width30,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .specialty!,
                                                                    1);
                                                              },
                                                              child: Container(
                                                                // padding: EdgeInsets.symmetric(
                                                                //   horizontal: Dimensions.width10,
                                                                //   vertical: Dimensions.height10 / 2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      width:
                                                                          1.5,
                                                                      color: const Color(
                                                                          0xff966C3B)),
                                                                ),
                                                                child: AppIcon(
                                                                  weight: 10,
                                                                  size: 22,
                                                                  iconSize:
                                                                      Dimensions
                                                                          .iconSize24,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  iconColor: Color(
                                                                      0xff966C3B),
                                                                  icon:
                                                                      Icons.add,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Positioned(
                                                          left: Dimensions
                                                                  .width30 *
                                                              1.8,
                                                          child: IntegerText(
                                                            color: Colors
                                                                .black54
                                                                .withOpacity(
                                                                    0.7),
                                                            text:
                                                                _cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                            fontWeight: FontWeight
                                                                .w500, //recommendedSpecialty.inCartItems.toString(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ])
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              });
                        },
                      )),
                ),
              )
            : NoItems();
      }),
    );
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  GetBuilder<CartController> buildBottomNavigation() {
    return GetBuilder<CartController>(
      builder: (cartController) {
        var user = Provider.of<UserModel?>(context);
        totalOrderAmount = cartController.totalAmount;
        int totalDiscount = 0;
        int totalDiscountedItems = 0;
        int totalDiscountedCarWashItems = 0;
        int totalCarWashDiscount = 0;
        List<dynamic> orderList = cart;
        List<dynamic> orderMessages = chatRoom;
        String laundryApplied = 'Apply laundry subscription?';

        //Check all subscription items
        final List<dynamic> carWashSubList = [];
        final List<dynamic> laundrySubList = [];

        for (var i = 0; i < cartController.getItems.length; i++) {
          switch (cartController.getItems[i].id) {
            case 59:
            case 16:
            case 17:
            case 10:
            case 11:
            case 14:
            case 13:
            case 15:
            case 58:
              laundrySubList.add({
                'img': cartController.getItems[i].img,
                'name': cartController.getItems[i].name,
              });

              totalDiscountedItems += cartController.getItems[i].quantity!;
              totalDiscount += (cartController.getItems[i].price! *
                  cartController.getItems[i].quantity!);
              break;
          }
          switch (cartController.getItems[i].id) {
            case 401:
            case 402:
            case 403:
            case 404:
              carWashSubList.add({
                'img': cartController.getItems[i].img,
                'name': cartController.getItems[i].name
              });
              totalDiscountedCarWashItems +=
                  cartController.getItems[i].quantity!;
              totalCarWashDiscount += (cartController.getItems[i].price! *
                  cartController.getItems[i].quantity!);
              break;
          }
        }
        int itemCount = cartController.totalItems;

        //Subscription status
        _laundrySubscription = user == null
            ? 4
            : totalDiscountedItems == 0
                ? 3
                : _laundrySubscription;
        _carWashSubscription = user == null
            ? 4
            : totalDiscountedCarWashItems == 0
                ? 3
                : _carWashSubscription;

        //Number of discounted items
        _laundryItemCount = totalDiscountedItems;
        _carWashItemCount = totalDiscountedCarWashItems;

        //Discount amounts
        _laundryDiscount = totalDiscount;
        _carWashDiscount = totalCarWashDiscount;

        return cartController.getItems.isNotEmpty
            ? Stack(
                children: [
                  Container(
                    height: Dimensions.bottomHeightBar * 2.7,
                    decoration: bottomBoxDecoration(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: Dimensions.height10,
                      ),
                      child: ValueListenableBuilder(
                          valueListenable: _switch,
                          builder: (context, value, _) {
                            return MainBottomContainer(
                              totalOrderAmount: totalOrderAmount,
                              totalDiscountedCarWashItems:
                                  totalDiscountedCarWashItems,
                              totalDiscountedItems: totalDiscountedItems,
                              isShowDialog: showSubscriptionDialog,
                              laundrySubscription: _laundrySubscription,
                              carWashSubscription: _carWashSubscription,
                              status: status,
                              washType: washType,
                              laundryLastDate: _laundryLastDate,
                              laundryNextDate: _laundryNextDate,
                              carWashLastDate: _carWashLastDate,
                              carWashNextDate: _carWashNextDate,
                              lastDate: lastDate,
                              nextDate: nextDate,
                              itemCount: discountedItems,
                              discount: discount,
                              laundryItemCount: _laundryItemCount,
                              laundryDiscount: _laundryDiscount,
                              carWashItemCount: _carWashItemCount,
                              carWashDiscount: _carWashDiscount,
                            );
                          }),
                    ),
                  ),
                  PaymentRoute()
                ],
              )
            : Container(
                height: Dimensions.screenHeight / 3,
              );
      },
    );
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  BoxDecoration bottomBoxDecoration() {
    return BoxDecoration(
      color: AppColors.six.withOpacity(0.6),
      border: Border.all(
        width: 0,
        color: Color(0xff9A9484).withOpacity(0.4),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radius30 * 2),
        topRight: Radius.circular(Dimensions.radius30 * 2),
      ),
    );
  }
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  //////////////////SECTION DIVIDER////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  //Page features

  _confirmRemove(String item, int index) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return BottomDeleteSheet(
          index: index,
          expected: 'Remove item',
          headerText: 'Remove $item from cart?',
          action: 'Remove',
        );
      },
    );
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  _clearCart() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return BottomDeleteSheet(
          expected: 'Clear cart',
          headerText: 'Clear items?',
          action: 'Clear',
        );
      },
    );
  }
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
class SubscriptionDialog extends StatefulWidget {
  const SubscriptionDialog({
    super.key,
    required this.subscriptionStatus,
    required this.laundryOffer,
    required this.lastDate,
    required this.nextDate,
    required this.carWashOffer,
    required this.washType,
    required this.itemCount,
    required this.discount,
    required this.showDialog,
    required this.showSubscriptionSignUp,
  });
  final int subscriptionStatus;
  final int? laundryOffer;
  final int? carWashOffer;
  final String? washType;
  final String? lastDate;
  final String? nextDate;
  final int itemCount;
  final int discount;
  final ValueNotifier<bool> showDialog;
  final ValueNotifier<bool> showSubscriptionSignUp;

  @override
  State<SubscriptionDialog> createState() => _SubscriptionDialogState();
}

class _SubscriptionDialogState extends State<SubscriptionDialog> {
  void _getHelpPage() {
    Get.to(() => const GetHelpPopUp(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 100));
  }

  void _getSubscription(bool isDismissDialog) {
    isDismissDialog = !isDismissDialog;
  }

  @override
  Widget build(BuildContext context) {
    final String washText = widget.washType == 'laundry'
        ? 'wash up to 5kg of laundry per week.'
        : 'book a weekly wash, and 2 callouts a month.';

    final String suffix = widget.itemCount > 1 ? 'items' : 'item';

    final List<List<String>> content = [
      [
        'Your ${widget.washType} subscription plan is not yet active. You can sign up for the ${widget.washType} subscription, and this will allow you to  ${washText}',
        'Subscribe Now',
        'Maybe Later',
        'Get Subscription'
      ],
      [
        'Choose ${widget.washType} subscription to apply R${widget.discount}.00 discount for ${widget.itemCount} ${widget.washType} ${suffix}?',
        'Apply Discount',
        'Cancel',
        'Pay with subscription'
      ],
      [
        'You last used your subscription on ${widget.lastDate}, this means your next active subscription is on ${widget.nextDate}. Alternatively you can always proceed to checkout to make payment.',
        'Get help',
        'Got it',
        'Not Active'
      ],
      [
        'Your current cart does not have any ${widget.washType} items in it. This payment option is not available!',
        'Get Help',
        'Got it',
        'Not Available'
      ],
      ['Please sign in to continue.', 'Sign In', 'Maybe Later', 'Not Signed In']
    ];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: dialogText(
              text: content[widget.subscriptionStatus][3],
              weight: FontWeight.w600,
              color: AppColors.fontColor,
              size: Dimensions.font26 / 1.1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: dialogText(
              text: content[widget.subscriptionStatus][0],
              size: Dimensions.font16 / 1.1,
              color: AppColors.paraColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.showDialog.value = !widget.showDialog.value;
                  },
                  child: dialogLocalButton(
                    text: content[widget.subscriptionStatus][2],
                    callAction: 0,
                    color: Color(0xff9A9483),
                    index: widget.subscriptionStatus,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.subscriptionStatus == 0) {
                      widget.showDialog.value = !widget.showDialog.value;
                      widget.showSubscriptionSignUp.value =
                          !widget.showSubscriptionSignUp.value;
                    } else {
                      () {};
                    }
                    // widget.subscriptionStatus == 2 ||
                    //         widget.subscriptionStatus == 3
                    //     ? _getHelpPage()
                    //     : _showLoader();
                  },
                  child: dialogLocalButton(
                    text: content[widget.subscriptionStatus][1],
                    callAction: 1,
                    color: Colors.white,
                    index: widget.subscriptionStatus,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class dialogText extends StatelessWidget {
  const dialogText({
    super.key,
    required this.text,
    this.weight = FontWeight.w500,
    this.color = Colors.black87,
    required this.size,
  });
  final String text;
  final FontWeight? weight;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IntegerText(
      maxLines: 10,
      overFlow: TextOverflow.ellipsis,
      text: text,
      color: color,
      fontWeight: weight,
      size: size,
    );
  }
}

class dialogLocalButton extends StatelessWidget {
  const dialogLocalButton({
    super.key,
    required this.text,
    required this.callAction,
    required this.color,
    required this.index,
  });

  final String text;
  final int callAction;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight / 18.9,
      // width: Dimensions.screenWidth / 2.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            callAction == 1 ? Color(0xffCFC5A5) : Colors.white,
            callAction == 1 ? Color(0xff9A9483) : Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.radius20 * 3),
        ),
        border: callAction == 1
            ? null
            : Border.all(color: Color(0xff9A9483), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: index == 0
                ? Dimensions.width20 * 1.1
                : Dimensions.width20 * 1.4),
        child: Center(
          child: SmallText(
            text: text,
            size: Dimensions.font16 / 1.1,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
      ),
      child: Center(
        child: Container(
          width: Dimensions.height20 * 5.4,
          height: Dimensions.height20 * 5.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(1, 2),
              ),
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            color: Colors.white,
          ),
          child: Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: const Color(0xffB09B71),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
