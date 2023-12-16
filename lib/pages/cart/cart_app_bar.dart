import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
