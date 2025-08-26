import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: theme.backgroundColor,
      child: Scrollbar(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              pinned: false,
              title: 'Explore',
            ),
            _buildSliverSearchBar(),
            _buildSliverBody(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverSearchBar() {
    var theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.appBarTheme.foregroundColor,
      automaticallyImplyLeading: false,
      pinned: true,
      elevation: 0.0,
      title: SearchFieldWidget(),
    );
  }

  SliverList _buildSliverBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SingleChildScrollView(
            child: Column(
              children: [
                MaterialTile(
                  title: 'Categories',
                ),
                CategoriesList(),
                MaterialTile(
                  title: 'Catelogue',
                ),
                CatelogueList(),
                MaterialTile(
                  title: 'Recommended For You',
                ),
                RecommendedList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
