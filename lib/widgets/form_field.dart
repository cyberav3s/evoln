import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    Key? key,
    required this.hint,
    required this.leading,
    required this.trailing,
    this.onLeadingPressed,
    required this.obscureText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final String hint;
  final String leading;
  final Widget? trailing;
  final VoidCallback? onLeadingPressed;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      height: defaultSize! * 6,
      decoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
          ),
        ],
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: TextFormField(
        validator: validator,
        cursorColor: Color(0xFF1C212F),
        textInputAction: TextInputAction.next,
        controller: controller,
        showCursor: true,
        style: TextStyle(
          color: Color(0xFF121212),
          fontFamily: 'Larken',
          fontSize: defaultSize * 1.5,
          decoration: TextDecoration.none,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(defaultSize * 2),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Larken',
            fontSize: defaultSize * 1.6,
            fontWeight: FontWeight.w100,
            decoration: TextDecoration.none,
          ),
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: IconButton(
            icon: SvgPicture.asset(leading),
            onPressed: () {},
          ),
          suffixIcon: trailing,
        ),
      ),
    );
  }
}
