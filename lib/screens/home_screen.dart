import 'package:evoln/elements/lists/crypto_list.dart';
import 'package:evoln/elements/lists/security_list.dart';
import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: theme.backgroundColor,
      child: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  color: theme.appBarTheme.iconTheme!.color,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
            pinned: true,
            title: 'Home',
          ),
          _buildSliverBody(),
        ],
      ),
    );
  }

  SliverList _buildSliverBody() {
    double? defaultSize = SizeConfig.defaultSize;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FeaturedCard(),
                  MaterialTile(
                    title: 'Featured',
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllScreen(
                              collection: 'Featured',
                              title: 'Featured',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: defaultSize! * 1.5,
                          fontFamily: 'Larken',
                        ),
                      ),
                    ),
                  ),
                  FeaturedList(),
                  MaterialTile(
                    title: 'Gaming',
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllScreen(
                              collection: 'Discover',
                              title: 'Gaming',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: defaultSize * 1.5,
                          fontFamily: 'Larken',
                        ),
                      ),
                    ),
                  ),
                  GamingList(),
                  MaterialTile(
                    title: 'Technology',
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllScreen(
                              collection: 'Discover',
                              title: 'Tech',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: defaultSize * 1.5,
                          fontFamily: 'Larken',
                        ),
                      ),
                    ),
                  ),
                  TechList(),
                  MaterialTile(
                    title: 'Security',
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllScreen(
                              collection: 'Discover',
                              title: 'Security',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: defaultSize * 1.5,
                          fontFamily: 'Larken',
                        ),
                      ),
                    ),
                  ),
                  SecurityList(),
                  MaterialTile(
                    title: 'Cryptocurrency',
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllScreen(
                              collection: 'Discover',
                              title: 'Cryptocurrency',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: defaultSize * 1.5,
                          fontFamily: 'Larken',
                        ),
                      ),
                    ),
                  ),
                  CryptoList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
