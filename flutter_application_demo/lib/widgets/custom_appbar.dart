import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: SvgPicture.asset("assets/settyl.logo.svg"),
      elevation: 0,
      automaticallyImplyLeading: false,
      //backgroundColor: Colors.transparent,
      backgroundColor: Color.fromRGBO(32, 32, 148, 1),
    );
  }
}
