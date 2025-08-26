import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/utils/constants.dart';
import 'package:evoln/widgets/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          cursorColor: Color(0xFF1A202E),
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          showCursor: true,
          decoration: InputDecoration(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
            color: theme.appBarTheme.iconTheme!.color,
            ),
            border: InputBorder.none,
            hintText: "Search for articles",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: defaultSize! * 1.6,
              fontFamily: 'Larken',
              decoration: TextDecoration.none,
            ),
          ),
          style: TextStyle(
            color: Color(0xFF1A202E),
            fontSize: defaultSize * 1.5,
            fontFamily: 'Larken',
            decoration: TextDecoration.none,
          ),
          onChanged: (newText) {
            showSearch(
              context: context,
              query: newText,
              delegate: MySearchDelegate(),
            );
          },
        ),
      ),
    );
  }
}