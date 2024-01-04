import 'package:flutter/cupertino.dart';

import 'LayoutUtils.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper(
      {super.key,
      required this.mobile,
      required this.desktop,
      required this.tablet});

  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (LayoutUtils.isMobile(constrains.maxWidth)) {
        return mobile;
      } else if (LayoutUtils.isTablet(constrains.maxWidth)) {
        return tablet;
      } else {
        return desktop;
      }
    });
  }
}
