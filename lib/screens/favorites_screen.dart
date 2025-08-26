import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key, required this.initialAnimation}) : super(key: key);

  final Animation<double> initialAnimation;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  double? defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: theme.backgroundColor,
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/close.svg',
                    height: defaultSize! * 4,
                    width: defaultSize! * 4,
                    color: theme.appBarTheme.iconTheme!.color,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              pinned: true,
              title: 'Favorites',
            ),
            _buildSliverBody(),
          ],
        ),
      ),
    );
  }

  SliverList _buildSliverBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Scrollbar(
            child: FavoritesList(),
          ),
        ],
      ),
    );
  }
}
