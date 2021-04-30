import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.redAccent[700],
      title: Text(
        'croissantRouge'.tr,
        //style: GoogleFonts.ptSans(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
