import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/laundry_specialty_controller.dart';
import '../../controllers/popular_specialty_controller.dart';
import '../../controllers/recommended_specialty_controller.dart';
import '../../models/cart_model.dart';
import '../../models/popular_specialty_model.dart';
import '../../routes/route_helper.dart';
import '../../services/firebase_storage_service.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/miscellaneous/app_icon.dart';
import '../../widgets/texts/big_text.dart';
import '../../widgets/texts/flexible_font.dart';
import '../../widgets/texts/integers_and_doubles.dart';
import '../../widgets/texts/small_text.dart';

class SpecialtyPageBody extends StatefulWidget {
  final String? area;
  const SpecialtyPageBody({Key? key, this.area}) : super(key: key);

  @override
  _SpecialtyPageBodyState createState() => _SpecialtyPageBodyState();
}

class _SpecialtyPageBodyState extends State<SpecialtyPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  late final String? _area;

  String? superhero;

  @override
  void initState() {
    super.initState();
    _area = widget.area;
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_area == 'Midrand') {}

    return LayoutBuilder(builder: (context, constraints) {
      double logicalPixels = 411.0;
      double screenWidth = MediaQuery.of(context).size.width;
      bool isSmallestDevice = screenWidth <= logicalPixels;
      return StreamProvider<List<SpecialtyModel>>.value(
        value: DatabaseService().specialties,
        initialData: [],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Top Slider Section
            Container(
              margin: EdgeInsets.only(bottom: Dimensions.height20),
              child: Stack(
                children: [
                  GetBuilder<RecommendedSpecialtyController>(
                      builder: (recommendedSpecialties) {
                    return recommendedSpecialties.isLoaded
                        ? SizedBox(
                            height: Dimensions.pageView / 1.4,
                            child: PageView.builder(
                                controller: pageController,
                                itemCount: recommendedSpecialties
                                    .recommendedSpecialtyList.length,
                                itemBuilder: (context, position) {
                                  return _buildPageItem(
                                      position,
                                      recommendedSpecialties
                                          .recommendedSpecialtyList[position]);
                                }),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Skeleton(
                                  height: Dimensions.pageView / 1.4,
                                  color: Colors.black.withOpacity(0.04),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(
                                          width: 200,
                                          height: 15,
                                          color: Colors.black.withOpacity(0.04),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Skeleton(
                                          width: 160,
                                          height: 15,
                                          color: Colors.black.withOpacity(0.04),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Skeleton(
                                          width: 100,
                                          height: 15,
                                          color: Colors.black.withOpacity(0.04),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                      ],
                                    ),
                                    Skeleton(
                                      width: 70,
                                      height: 60,
                                      color: Colors.black.withOpacity(0.04),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                  }),
                  GetBuilder<RecommendedSpecialtyController>(
                    builder: (recommendedSpecialties) {
                      return recommendedSpecialties.isLoaded
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: Dimensions.screenWidth / 2.5),
                              child: Center(
                                child:
                                    GetBuilder<RecommendedSpecialtyController>(
                                        builder: (recommendedSpecialties) {
                                  return DotsIndicator(
                                    dotsCount: recommendedSpecialties
                                            .recommendedSpecialtyList.isEmpty
                                        ? 1
                                        : recommendedSpecialties
                                            .recommendedSpecialtyList.length,
                                    position: _currPageValue,
                                    decorator: DotsDecorator(
                                      activeColor: _currPageValue != 0
                                          ? Color(0xff966C3B)
                                          : Color(0xff966C3B),
                                      color: _currPageValue != 1
                                          ? Colors.white
                                          : Colors.white,
                                      size: const Size.square(6.5),
                                      activeSize: const Size(8, 8),
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  );
                                }),
                              ),
                            )
                          : Container();
                    },
                  ),
                ],
              ),
            ),
            // Laundry Categories
            // list of services and images
            GetBuilder<CartController>(builder: (_cartController) {
              return Stack(
                children: [
                  GetBuilder<LaundrySpecialtyController>(
                    builder: (laundrySpecialties) {
                      var _specialty = laundrySpecialties.laundrySpecialtyList;
                      return laundrySpecialties.isLoaded
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: Dimensions.width15),
                              width: double.maxFinite,
                              color: Colors.grey.withOpacity(0.1),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      BigText(
                                        text: 'Laundry',
                                        color: AppColors.fontColor,
                                        weight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: Dimensions.width30 * 1.3,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.width10 / 1.5,
                                  ),
                                  Wrap(
                                    children: [
                                      Container(
                                        height: Dimensions.screenWidth / 3,
                                        width: Dimensions.screenWidth / 1.0,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: laundrySpecialties
                                              .laundrySpecialtyList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(RouteHelper
                                                    .getLaundrySpecialties(
                                                        index, 'home'));
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: Dimensions.height20 *
                                                        5.8,
                                                    height:
                                                        Dimensions.height20 * 6,
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width15,
                                                        right: isSmallestDevice
                                                            ? Dimensions.width15
                                                            : Dimensions
                                                                .width15),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 12),
                                                    decoration: BoxDecoration(
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius15),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        width: _cartController.getQuantity(
                                                                    laundrySpecialties
                                                                            .laundrySpecialtyList[
                                                                        index]) !=
                                                                0
                                                            ? 1.3
                                                            : 0,
                                                        color: _cartController.getQuantity(
                                                                    laundrySpecialties
                                                                            .laundrySpecialtyList[
                                                                        index]) !=
                                                                0
                                                            ? const Color(
                                                                0xff966C3B)
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40 /
                                                                                2),
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: _cartController.getQuantity(laundrySpecialties.laundrySpecialtyList[
                                                                              index]) !=
                                                                          0
                                                                      ? const Color(
                                                                          0xff966C3B)
                                                                      : Color(
                                                                          0xff9A9483),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: _cartController
                                                                            .getQuantity(laundrySpecialties.laundrySpecialtyList[index]) !=
                                                                        0
                                                                    ? Text(
                                                                        '${_cartController.getQuantity(laundrySpecialties.laundrySpecialtyList[index])}',
                                                                        style: TextStyle(
                                                                            fontSize: Dimensions.font16 /
                                                                                1.2,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            color:
                                                                                const Color(0xff966C3B),
                                                                            fontWeight: FontWeight.w600),
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: const Color(
                                                                            0xff9A9483),
                                                                        size: Dimensions.font16 /
                                                                            1.05,
                                                                      ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Image(
                                                              height: 30,
                                                              image: AssetImage(
                                                                  laundrySpecialties
                                                                      .laundrySpecialtyList[
                                                                          index]
                                                                      .createAt!),
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                      .width10 /
                                                                  2,
                                                            ),
                                                            IntegerText(
                                                              size: Dimensions
                                                                      .font16 /
                                                                  1.4,
                                                              text: laundrySpecialties
                                                                  .laundrySpecialtyList[
                                                                      index]
                                                                  .name!,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .fontColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Skeleton(
                                        width: 90,
                                        height: 15,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Skeleton(
                                        width: 90,
                                        height: 15,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  Row(
                                    children: [
                                      Skeleton(
                                        width: Dimensions.screenWidth / 3.8,
                                        height: Dimensions.screenHeight / 8,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Skeleton(
                                        width: Dimensions.screenWidth / 3.8,
                                        height: Dimensions.screenHeight / 8,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Skeleton(
                                        width: Dimensions.screenWidth / 3.8,
                                        height: Dimensions.screenHeight / 8,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Skeleton(
                                        width: Dimensions.screenWidth / 13.999,
                                        height: Dimensions.screenHeight / 8,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
              );
            }),
            SizedBox(
              height: Dimensions.height20,
            ),
            //popular specialties
            //list of services and images
            GetBuilder<CartController>(builder: (_cartController) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: GetBuilder<PopularSpecialtyController>(
                        builder: (popularSpecialties) {
                      return popularSpecialties.isLoaded
                          ? Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                BigText(
                                  text: 'Popular',
                                  weight: FontWeight.w600,
                                  color: AppColors.fontColor,
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 3),
                                  child: BigText(
                                    text: '.',
                                    color: Colors.black26,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: SmallText(
                                    text: 'Services',
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Skeleton(
                                    width: 90,
                                    height: 15,
                                    color: Colors.black.withOpacity(0.04),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Skeleton(
                                    width: 90,
                                    height: 15,
                                    color: Colors.black.withOpacity(0.04),
                                  ),
                                ],
                              ),
                            );
                    }),
                  ),
                  GetBuilder<PopularSpecialtyController>(
                    builder: (popularSpecialties) {
                      return popularSpecialties.isLoaded
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: popularSpecialties
                                  .popularSpecialtyList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                  ),
                                  height: Dimensions.screenHeight / 7.8,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.screenHeight / 100),
                                  margin: EdgeInsets.only(
                                    left: Dimensions.screenWidth / 25,
                                    right: Dimensions.screenWidth / 70,
                                    bottom: Dimensions.height20,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          RouteHelper.getPopularSpecialties(
                                              index, 'home'));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //image section
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 6),
                                          padding: const EdgeInsets.all(8),
                                          width: Dimensions.height20 * 4.5,
                                          height: Dimensions.height20 * 4.5,
                                          decoration: BoxDecoration(
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
                                                width: _cartController.getQuantity(
                                                            popularSpecialties
                                                                    .popularSpecialtyList[
                                                                index]) !=
                                                        0
                                                    ? 1.3
                                                    : 0,
                                                color: _cartController.getQuantity(
                                                            popularSpecialties
                                                                    .popularSpecialtyList[
                                                                index]) !=
                                                        0
                                                    ? const Color(0xff966C3B)
                                                    : Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                              color: Colors.white),
                                          child: Center(
                                            child: Image(
                                              image: AssetImage(
                                                  popularSpecialties
                                                      .popularSpecialtyList[
                                                          index]
                                                      .material!),
                                              height: Dimensions.height45 +
                                                  Dimensions.height10,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        //text container
                                        Expanded(
                                          child: SizedBox(
                                            height:
                                                Dimensions.listViewTextContSize,
                                            // margin: EdgeInsets.symmetric(
                                            //     horizontal: Dimensions.width15),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Dimensions.width10),
                                              child: Stack(
                                                children: [
                                                  IntegerText(
                                                    overFlow: TextOverflow.fade,
                                                    size: Dimensions.font16,
                                                    text: popularSpecialties
                                                        .popularSpecialtyList[
                                                            index]
                                                        .name,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.mainColor2,
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    top: 25,
                                                    child: IntegerText(
                                                      overFlow:
                                                          TextOverflow.fade,
                                                      text: popularSpecialties
                                                              .popularSpecialtyList[
                                                                  index]
                                                              .provider +
                                                          ', Randburg',
                                                      color:
                                                          AppColors.titleColor,
                                                      size: Dimensions.font16,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 50,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: Dimensions
                                                                  .width15 /
                                                              5.05,
                                                          horizontal: Dimensions
                                                                  .width15 /
                                                              3.05),
                                                      child: IntegerText(
                                                        text:
                                                            'R ${popularSpecialties.popularSpecialtyList[index].price!.toString()}.00',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .mainColor2,
                                                        size:
                                                            Dimensions.font16 /
                                                                1.1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: _cartController.getQuantity(
                                                              popularSpecialties
                                                                      .popularSpecialtyList[
                                                                  index]) !=
                                                          0
                                                      ? 1.3
                                                      : 1,
                                                  color: _cartController.getQuantity(
                                                              popularSpecialties
                                                                      .popularSpecialtyList[
                                                                  index]) !=
                                                          0
                                                      ? const Color(0xff966C3B)
                                                      : const Color(0xff9A9484),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40 / 2),
                                                color: Colors.white),
                                            child: _cartController.getQuantity(
                                                        popularSpecialties
                                                                .popularSpecialtyList[
                                                            index]) !=
                                                    0
                                                ? Center(
                                                    child: Text(
                                                      '${_cartController.getQuantity(popularSpecialties.popularSpecialtyList[index])}',
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                                  .font16 +
                                                              Dimensions
                                                                      .font20 /
                                                                  8,
                                                          fontFamily: 'Poppins',
                                                          color: const Color(
                                                              0xff966C3B),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: const Color(
                                                          0xff9A9484),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: Dimensions.screenHeight / 5,
                                      ),
                                      Skeleton(
                                        width: Dimensions.height20 * 4.5,
                                        height: Dimensions.height20 * 4.5,
                                        color: Colors.black.withOpacity(0.04),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Skeleton(
                                            width: 120,
                                            height: 20,
                                            color:
                                                Colors.black.withOpacity(0.04),
                                          ),
                                          SizedBox(
                                            height: Dimensions.width10,
                                          ),
                                          Skeleton(
                                            width: 100,
                                            height: 20,
                                            color:
                                                Colors.black.withOpacity(0.04),
                                          ),
                                          SizedBox(
                                            height: Dimensions.width10,
                                          ),
                                          Skeleton(
                                            width: 60,
                                            height: 20,
                                            color:
                                                Colors.black.withOpacity(0.04),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Skeleton(
                                      width: 30,
                                      height: 30,
                                      color: Colors.black.withOpacity(0.04),
                                    ),
                                  )
                                ],
                              ),
                            );
                    },
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight / 10,
                  )
                ],
              );
            }),
          ],
        ),
      );
    });
  }

  Widget _buildPageItem(int index, SpecialtyModel recommendedSpecialty) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currScale, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currScale, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currScale, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getRecommendedSpecialities(index, 'home'));
            // RouteHelper.getRecommendedSpecialtyGridView());
          },
          child: Stack(
            children: [
              Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width10 / 3,
                    right: Dimensions.width10 / 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff966C3B).withOpacity(0.4),
                      Color(0xffA0937D).withOpacity(0.4),
                    ],
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(recommendedSpecialty.img!),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5,
                      offset: Offset(1, 2),
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Container(
              width: Dimensions.screenWidth / 2.2,
              height: Dimensions.height30,
              padding: EdgeInsets.all(Dimensions.height10 / 3),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5,
                      offset: Offset(1, 2),
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5,
                      offset: Offset(0, -1),
                    ),
                  ],
                  border: Border.all(
                    width: 1.5,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20)),
              child: Image(
                fit: BoxFit.fitHeight,
                image: AssetImage(recommendedSpecialty.time!),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Skeleton extends StatelessWidget {
  Skeleton({
    Key? key,
    this.height,
    this.width,
    required this.color,
  }) : super(key: key);

  final double? height, width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
