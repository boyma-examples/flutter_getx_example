import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'feature_list_body.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: _AppBarWithCircle(
                  minExtended: kToolbarHeight,
                  maxExtended: size.height * 0.35,
                  onHideCircle: () {
                    WidgetsBinding.instance?.addPostFrameCallback((duration) {
                      _showSnack(context, "_showSnack");
                    });
                  }),
            ),
            SliverToBoxAdapter(
              child: FeatureListBody(size: size),
            )
          ],
        ),
      ),
    );
  }

  void _showSnack(
    BuildContext context,
    String s,
  ) {
    Get.snackbar(
      'Snackbar',
      s,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class _AppBarWithCircle extends SliverPersistentHeaderDelegate {
  final double maxExtended;
  final double minExtended;
  final Function? onHideCircle;

  const _AppBarWithCircle({
    required this.maxExtended,
    required this.minExtended,
    this.onHideCircle,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final percent = shrinkOffset / maxExtended;

    if (onHideCircle != null && isEndOfBar(percent)) {
      onHideCircle!();
    }

    return Stack(
      children: [
        _Circle(
          percent: percent,
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxExtended;

  @override
  double get minExtent => minExtended;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  bool isEndOfBar(double percent) {
    return percent == 1;
  }
}

class _Circle extends StatelessWidget {
  final double percent;
  final double circleHeight;

  const _Circle({
    Key? key,
    required this.percent,
    this.circleHeight = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -circleHeight / 2,
      left: -circleHeight / 2,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(getAngle()),
        child: SvgPicture.asset(
          "assets/images/circle.svg",
          width: circleHeight,
          height: circleHeight,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  double getAngle() {
    return percent * getRadians(360);
  }

  num getRadians(int angle) {
    const koeff = 3.14 / 180;
    return angle * koeff;
  }
}
