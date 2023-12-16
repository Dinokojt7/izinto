import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/texts/integers_and_doubles.dart';
import '../../../widgets/texts/small_text.dart';

class HeaderDetails extends StatelessWidget {
  const HeaderDetails({
    super.key,
    required String name,
    required String street,
    required String address,
    required String area,
  })  : _name = name,
        _street = street,
        _address = address,
        _area = area;

  final String _name;
  final String _street;
  final String _address;
  final String _area;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: SmallText(
                    text: _name,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    size: Dimensions.font16,
                    height: 1.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Wrap(
                    children: [
                      IntegerText(
                        text: _street,
                        overFlow: TextOverflow.fade,
                        color: AppColors.titleColor,
                        height: 1.5,
                        size: Dimensions.font16 / 1.1,
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      IntegerText(
                        text: '.',
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        height: 0.9,
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      IntegerText(
                        text: _address,
                        maxLines: 1,
                        color: AppColors.titleColor,
                        height: 1.5,
                        size: Dimensions.font16 / 1.1,
                        overFlow: TextOverflow.fade,
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      IntegerText(
                        text: '.',
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        height: 0.9,
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      IntegerText(
                        text: _area,
                        color: AppColors.titleColor,
                        height: 1.5,
                        size: Dimensions.font16 / 1.1,
                        overFlow: TextOverflow.fade,
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
