import 'package:evoln/elements/lists/history_list.dart';
import 'package:evoln/services/db.dart';
import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

const int maxFailedLoadAttempts = 3;

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId1,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

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
                  'assets/icons/notification.svg',
                  color: theme.appBarTheme.iconTheme!.color,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ],
            pinned: true,
            title: 'Your Library',
          ),
          _buildSliverBody(),
        ],
      ),
    );
  }

  SliverList _buildSliverBody() {
    final DatabaseService _db = DatabaseService();
    var user = Provider.of<User?>(context);
    double? defaultSize = SizeConfig.defaultSize;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildListTile(
                    title: 'Saved',
                    path: 'Saved',
                    icon: 'assets/icons/bookmark_fill.svg',
                    onTap: () {
                      _showInterstitialAd();
                      Navigator.pushNamed(context, '/saved');
                    },
                  ),
                  _buildListTile(
                    title: 'Favorites',
                    path: 'Favorites',
                    icon: 'assets/icons/favorite_fill.svg',
                    onTap: () {
                      _showInterstitialAd();
                      Navigator.pushNamed(context, '/favorites');
                    },
                  ),
                  SizedBox(height: defaultSize! * 1),
                  MaterialTile(
                    title: 'Your History',
                    trailing: GestureDetector(
                      onTap: () {
                        _db.clearHistory(user: user);
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: defaultSize * 1.5,
                          fontFamily: 'Larken',
                        ),
                      ),
                    ),
                  ),
                  HistoryList(),
                  SizedBox(height: defaultSize * 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _articlesStream(String path) {
    var user = Provider.of<User?>(context);
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection(path)
        .snapshots();
  }

  ListTile _buildListTile({
    String? title,
    VoidCallback? onTap,
    String? icon,
    required String path,
  }) {
    var theme = Theme.of(context);
    double? defaultSize = SizeConfig.defaultSize;
    return ListTile(
      leading: Container(
        height: defaultSize! * 6,
        width: defaultSize * 6,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(icon!, color: theme.iconTheme.color),
        ),
      ),
      title: Text(
        title!,
        style: TextStyle(
          fontFamily: 'Larken',
          fontSize: defaultSize * 1.6,
        ),
      ),
      subtitle: StreamBuilder(
          stream: _articlesStream(path),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                'Loading...',
                style: TextStyle(
                  fontFamily: 'Larken',
                  fontSize: defaultSize * 1.2,
                  fontWeight: FontWeight.w600,
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(
                'Error',
                style: TextStyle(
                  fontFamily: 'Larken',
                  fontSize: defaultSize * 1.2,
                  fontWeight: FontWeight.w100,
                ),
              );
            }
            return Text(
              "${snapshot.data!.docs.length.toString()} items",
              style: TextStyle(
                fontFamily: 'Larken',
                fontSize: defaultSize * 1.2,
              ),
            );
          }),
      onTap: onTap,
    );
  }
}
