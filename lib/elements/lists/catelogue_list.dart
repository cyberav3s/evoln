import 'package:animate_do/animate_do.dart';
import 'package:evoln/elements/cards/catelogue_card.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/models/catelogues.dart';
import 'package:evoln/screens/catelogue_screen.dart';
import 'package:flutter/material.dart';

class CatelogueList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> catelogueCards() {
      List<Widget> cards = [];
      for (var catelogue in catelogueList) {
        cards.add(
          FadeIn(
            child: CatelogueCard(
              catelogue: catelogue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CatelogueScreen(sortBy: catelogue.title),
                  ),
                );
              },
            ),
          ),
        );
      }

      return cards;
    }

    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      height: defaultSize! * 40,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.5),
        physics: NeverScrollableScrollPhysics(),
        children: catelogueCards(),
      ),
    );
  }
}
