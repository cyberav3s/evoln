import 'package:animate_do/animate_do.dart';
import 'package:evoln/elements/buttons/categories_button.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/models/categories.dart';
import 'package:evoln/screens/categories_screen.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double? defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultSize! * 1.5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10.0,
          runSpacing: 8.0,
          runAlignment: WrapAlignment.center,
          children: categoriesList.map((chip) {
            return FadeInRight(
              child: CategoriesButton(
                title: chip.title,
                icon: chip.icon,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategorieScreen(title: chip.title),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
