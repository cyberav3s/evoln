import 'package:flutter/material.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesButton extends StatelessWidget {
  const CategoriesButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    var theme = Theme.of(context);
    return MaterialButton(
      color: theme.cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      onPressed: onPressed,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              icon,
              color: theme.appBarTheme.iconTheme!.color,
              height: defaultSize! * 1.8, 
            ),
            SizedBox(width: defaultSize * 0.8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Larken',
                fontSize: defaultSize * 1.8, 
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
