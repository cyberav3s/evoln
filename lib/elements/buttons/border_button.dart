import 'package:evoln/config/size/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evoln/utils/constants.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({Key? key, required this.title, this.onPressed}) : super(key: key);

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: BorderSide(
          color: kButtonColor.withOpacity(0.3),
          width: 0.5,
        )
      ),
      padding: EdgeInsets.all(0),
      height: defaultSize! * 5,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/google.svg',
              height: defaultSize * 2.5,
              width: defaultSize * 2.5,
            ),
            SizedBox(width: defaultSize * 1),
            Text(
             title,
               style: TextStyle(
                 color: Color(0xFF1A202E),
                 fontFamily: 'Larken',
                 fontSize: defaultSize * 1.8,
                 fontWeight: FontWeight.w200,
               ),
             ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
