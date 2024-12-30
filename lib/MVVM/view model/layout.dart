import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget mobileView;
  final Widget deskTopView;
  const Layout({super.key, required this.mobileView, required this.deskTopView});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileView;
        } else {
          return deskTopView;
        }
      },
    );
  }
}
