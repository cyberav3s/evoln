import 'package:evoln/config/size/size_config.dart';
import 'package:flutter/material.dart';

class MaterialTile extends StatelessWidget {
  const MaterialTile({
    Key? key,
    required this.title,
    this.trailing,
  }) : super(key: key);

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Larken',
          fontSize: defaultSize! * 2.4,
        ),
       ),
      trailing: trailing,
    );
  }
}
