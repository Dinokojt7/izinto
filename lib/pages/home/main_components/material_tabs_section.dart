import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class MaterialTabsSection extends StatelessWidget {
  const MaterialTabsSection({
    super.key,
    required bool isSpecialtiesLoaded,
    required TabController tabController,
    required List<Widget> tabs,
  })  : _tabController = tabController,
        _tabs = tabs,
        isSpecialtiesLoaded = isSpecialtiesLoaded;

  final TabController _tabController;
  final List<Widget> _tabs;
  final bool isSpecialtiesLoaded;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.black45,
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: !isSpecialtiesLoaded
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.04),
              width: 0.5,
            ),
          ),
        ),
        child: Stack(
          children: [
            TabBar(
              isScrollable: true,
              indicatorWeight: Dimensions.width10 / 9,
              indicatorSize: TabBarIndicatorSize.label,
              physics: AlwaysScrollableScrollPhysics(),
              indicatorColor: isSpecialtiesLoaded
                  ? AppColors.six.withOpacity(0.2)
                  : Colors.transparent,
              controller: _tabController,
              tabs: _tabs,
              labelColor: AppColors.fontColor,
              unselectedLabelColor: Colors.grey,
            ),
            !isSpecialtiesLoaded
                ? Container(
                    height: Dimensions.screenHeight / 9.8,
                    width: Dimensions.screenWidth,
                    color: Colors.transparent,
                    child: Column(),
                  )
                : Container(
                    color: Colors.transparent,
                    height: 0.0000000001,
                  )
          ],
        ),
      ),
    );
  }
}
