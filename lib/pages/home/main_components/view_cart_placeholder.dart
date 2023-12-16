import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class ViewCartPlaceholder extends StatelessWidget {
  const ViewCartPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
      ),
      onPressed: () {},
      label: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.height20 / 1.8,
          bottom: Dimensions.height20 / 1.8,
        ),
        child: Transform.scale(
          scale: 0.5,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: AppColors.six,
            ),
          ),
        ),
      ),
    );
  }
}
