import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    this.actions,
    required this.pinned,
    required this.title,
    this.leading,
  }) : super(key: key);

  final List<Widget>? actions;
  final bool pinned;
  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double? defaultSize = SizeConfig.defaultSize;
    return SliverAppBar(
      expandedHeight: defaultSize! * 14,
      backgroundColor: theme.appBarTheme.backgroundColor,
      shadowColor: kShadowColor,
      elevation: 5.0,
      automaticallyImplyLeading: false,
      pinned: pinned,
      onStretchTrigger: () async {
        print('Load more data!');
      },
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.appBarTheme.foregroundColor,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: defaultSize * 0.5,
              width: defaultSize * 5,
              decoration: BoxDecoration(
                color: Color(0xFF39FF7D),
                borderRadius: BorderRadius.circular(1.0),
              ),
              margin: EdgeInsets.only(
                bottom: defaultSize * 1,
                left: defaultSize * 1.8,
              ),
            ),
          ),
        ),
        collapseMode: CollapseMode.pin,
        stretchModes: [
          StretchMode.zoomBackground,
        ],
        titlePadding: EdgeInsets.only(
         left: defaultSize * 1.8,
         top: defaultSize * 2,
         bottom: defaultSize * 1.5,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Larken',
          fontSize: defaultSize * 2.4,
          fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
