import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Image.asset('assets/images/png2.png',
      fit: BoxFit.contain,
      // fit: BoxFit.cover,
      // fit: BoxFit.fill,
      // fit: BoxFit.fitHeight,
      // fit: BoxFit.fitWidth,
      // fit: BoxFit.scaleDown,
      ),
    );
  }
}
