import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/models/catelogues.dart';
import 'package:flutter/material.dart';

class CatelogueCard extends StatelessWidget {
  const CatelogueCard({Key? key, required this.catelogue, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  final Catelogue catelogue;
  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      height: defaultSize! * 18,
      width: defaultSize * 23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        image: DecorationImage(
           image: AssetImage(catelogue.illustration),
           fit: BoxFit.cover,
        ),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: onTap,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize * 0.5, vertical: defaultSize * 0.5),
              child: Text(
               catelogue.title,
               style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Larken',
                fontSize: defaultSize * 1.8, 
                fontWeight: FontWeight.w600,
               ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
