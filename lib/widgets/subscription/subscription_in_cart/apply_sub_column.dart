import 'package:Izinto/widgets/subscription/subscription_in_cart/sub_column_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplySubColumn extends StatelessWidget {
  const ApplySubColumn({
    Key? key,
    required this.closeSubView,
  }) : super(key: key);

  final void Function() closeSubView;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SubColumnGesture(
              closeSubView: closeSubView,
              icon: Icons.close,
            ),
          ],
        ),
      ],
    );
  }
}
