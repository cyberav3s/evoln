import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/utils/constants.dart';
import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  const RegularButton({Key? key, required this.title, this.onPressed}) : super(key: key);

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: EdgeInsets.all(0),
      height: defaultSize! * 5,
      color: kButtonColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Larken',
            fontSize: defaultSize * 1.8,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
