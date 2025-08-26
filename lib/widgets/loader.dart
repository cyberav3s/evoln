import 'package:flutter/material.dart';
import 'package:evoln/config/size/size_config.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    var theme = Theme.of(context);
    return Center(
        child: Container(
          height: defaultSize! * 4,
          width: defaultSize * 4,
          decoration: BoxDecoration(
            color: theme.cardColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Container(
            height: 18.0,
            width: 18.0,
            child: CircularProgressIndicator(
              color: Colors.greenAccent[400],
              strokeWidth: 2.5,
            ),
          ),
      ),
    );
  }
}
