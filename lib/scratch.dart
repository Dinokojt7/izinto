import 'package:Izinto/pages/cart/price_display.dart';
import 'package:Izinto/utils/colors.dart';
import 'package:Izinto/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainTest extends StatefulWidget {
  const MainTest({Key? key}) : super(key: key);

  @override
  State<MainTest> createState() => _MainTestState();
}

class _MainTestState extends State<MainTest> {
  final _counterNotifier = ValueNotifier<int>(0);

  ValueNotifier<bool> _switch = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> transactions = [
      ['Dec 2023', '', 'Statement', false],
      [
        'International Processing Fee',
        'Yesterday - Online Store',
        '-R18.50',
        false
      ],
      ['Google Inc', 'Yesterday - Online Store', '-R1856.12', false],
      ['Payment Received', 'Yesterday - Other Income', 'R4000.00', true],
      [
        'Terry Nedbank (Declined)',
        'Yesterday - Uncategorised',
        '-R5.56',
        false
      ],
      [
        'Bolt Servipid145408878 Bolt',
        'Yesterday - Other Income',
        'R644.04',
        true
      ],
      ['Cash Deposit', 'Yesterday - Fees', 'R820.56', true],
      ['Payd Pick N *bp Pnp Me', 'Yesterday - Groceries', '-R50.50', false],
      ['Prepaid Mobile Purchase Fee', 'Yesterday - Fees', '-R0.50', false],
      ['Telkom Mobile', 'Yesterday - Telephone', '-R20.00', false],
      ['Prepaid Electricity Purchase Fee', '3 Dec 2023 - Fees', '-R1.00', true],
      ['Electricity', '3 Dec 2023  - Electricity', '-R40.00', false],
      ['Prepaid Mobile Purchase Fee', '1 Dec 2023 - Fees', '-R0.50', false],
      ['Telkom Mobile', '1 Dec 2023 - Telephone', '-R20.00', false],
      ['Cash Deposit', '1 Dec 2023 - Cash Deposit', '-R340.00', true],
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/image/1.jpg'),
                width: Dimensions.screenWidth,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.grey.withOpacity(0.15)
                            : Colors.white,
                      ),
                      height: index == 0
                          ? Dimensions.screenHeight / 14
                          : Dimensions.screenHeight / 14,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20 / 3),
                      margin: EdgeInsets.only(
                        bottom: Dimensions.height20 / 3,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: index == 0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 1.0,
                                        top: 19.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //image section
                                        Text(
                                          transactions[index][0],
                                          style: TextStyle(
                                              fontSize: Dimensions.font16 +
                                                  Dimensions.font20 / 16,
                                              fontFamily: 'Hind',
                                              color: index == 0
                                                  ? Colors.black87
                                                      .withOpacity(0.82)
                                                  : Colors.black87
                                                      .withOpacity(0.73),
                                              fontWeight: index == 0
                                                  ? FontWeight.w600
                                                  : FontWeight.w500),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        //text container

                                        Row(
                                          children: [
                                            Text(
                                              transactions[index][2],
                                              style: TextStyle(
                                                  fontSize: index == 0
                                                      ? Dimensions.font16 +
                                                          Dimensions.font16 / 16
                                                      : Dimensions.font16 +
                                                          Dimensions.font20 /
                                                              16,
                                                  fontFamily: 'Hind',
                                                  color: index == 0
                                                      ? Colors.blue
                                                      : transactions[index][3]
                                                          ? Colors.green
                                                          : Colors.black87
                                                              .withOpacity(
                                                                  0.73),
                                                  fontWeight: index == 0
                                                      ? FontWeight.w600
                                                      : transactions[index][3]
                                                          ? FontWeight.w600
                                                          : FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: Dimensions.height15 / 3,
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Colors.blue,
                                                  size: Dimensions.iconSize16 /
                                                      1.1,
                                                  weight: 120,
                                                ),
                                                SizedBox(
                                                  height:
                                                      Dimensions.height15 / 8,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //image section
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              transactions[index][0],
                                              style: TextStyle(
                                                  fontSize: Dimensions.font16 +
                                                      Dimensions.font20 / 10,
                                                  fontFamily: 'Hind',
                                                  color: index == 0
                                                      ? Colors.black87
                                                          .withOpacity(0.82)
                                                      : Colors.black87
                                                          .withOpacity(0.73),
                                                  fontWeight: index == 0
                                                      ? FontWeight.w600
                                                      : FontWeight.w500),
                                            ),
                                            Text(
                                              transactions[index][1],
                                              style: TextStyle(
                                                  fontSize:
                                                      Dimensions.font16 / 1.1,
                                                  fontFamily: 'Hind',
                                                  color: Colors.black54
                                                      .withOpacity(0.4),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        //text container

                                        Text(
                                          transactions[index][2],
                                          style: TextStyle(
                                              fontSize: index == 0
                                                  ? Dimensions.font16 +
                                                      Dimensions.font16 / 11
                                                  : Dimensions.font16 +
                                                      Dimensions.font20 / 11,
                                              fontFamily: 'Hind',
                                              color: index == 0
                                                  ? Colors.blue
                                                  : transactions[index][3]
                                                      ? Colors.lightGreen
                                                      : Colors.black87
                                                          .withOpacity(0.73),
                                              fontWeight: index == 0
                                                  ? FontWeight.w600
                                                  : transactions[index][3]
                                                      ? FontWeight.w600
                                                      : FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(height: Dimensions.width10 / 3),
                          index == 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    height: Dimensions.height15 / 25,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: Image(
            image: AssetImage('assets/image/3.png'),
            width: Dimensions.screenWidth,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _counterNotifier.dispose();
    super.dispose();
  }
}

class PayWithHere extends StatefulWidget {
  const PayWithHere({Key? key}) : super(key: key);

  @override
  State<PayWithHere> createState() => _PayWithHereState();
}

class _PayWithHereState extends State<PayWithHere> {
  final switchValue = ValueNotifier<bool>(false);
  _applySub(bool isSubscribed) {
    isSubscribed = !isSubscribed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth / 2,
      height: Dimensions.screenWidth / 3,
      margin:
          EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30 * 3),
        color: AppColors.six.withOpacity(0.7),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextVaried(
                  text: 'Pay with',
                  size: Dimensions.height18 * 0.82,
                ),
                ValueListenableBuilder(
                    valueListenable: switchValue,
                    builder: (context, value, _) {
                      return Switch.adaptive(
                          activeColor: AppColors.six,
                          activeTrackColor: Colors.white,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: switchValue.value,
                          onChanged: (value) {
                            switchValue.value = value;
                          });
                    })
              ],
            ),
            Row(
              children: [
                Container(
                  width: Dimensions.height45 / 1.4,
                  height: Dimensions.height45 / 1.8,
                  decoration: thisWidgetDecoration(),
                  child: Icon(
                    Icons.local_laundry_service_outlined,
                    color: Color(0xff9A9484),
                    size: Dimensions.iconSize16,
                  ),
                ),
                SizedBox(width: Dimensions.width10 / 2),
                TextVaried(
                  text: 'Car Wash subscription',
                  size: Dimensions.height18 * 0.62,
                ),
              ],
            ),
            SizedBox(height: Dimensions.height15),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width10 / 2.5),
              child: Row(
                children: [
                  TextVaried(
                    text: '0 / 20 kg',
                    size: Dimensions.height18 * 0.62,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration thisWidgetDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius20 / 1.3),
      color: Colors.white.withOpacity(0.7),
    );
  }

  @override
  void dispose() {
    switchValue.dispose();
    super.dispose();
  }
}
