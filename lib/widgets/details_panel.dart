import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/services/db.dart';
import 'package:evoln/services/functions.dart';
import 'package:evoln/utils/constants.dart';
import 'package:evoln/services/ad_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

const int maxFailedAttempts = 3;

class DetailsPanel extends StatefulWidget {
  const DetailsPanel({Key? key, required this.article, this.onClose})
      : super(key: key);

  final QueryDocumentSnapshot article;
  final VoidCallback? onClose;

  @override
  _DetailsPanelState createState() => _DetailsPanelState();
}

class _DetailsPanelState extends State<DetailsPanel> {
  final DatabaseService _db = DatabaseService();
  double? defaultSize = SizeConfig.defaultSize;
  final Functions _functions = Functions();
  bool _isFavorite = false;
  bool _isSaved = false;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  
  
  @override
  void initState() {
    _createInterstitialAd();
    Future.delayed(Duration.zero, () {
    checkSavedExists();
    checkFavoriteExists();
    });
    super.initState();
  }
  
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId2,
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
            if (_numInterstitialLoadAttempts <= maxFailedAttempts) {
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

  checkSavedExists() async {
    var user = Provider.of<User?>(context);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Saved')
        .doc(widget.article.id)
        .snapshots().listen((value) {
         bool state = value.get('saved');
          if (state == true) {
      setState(() {
        _isSaved = true;
      });
    } else {}
        });
  }

  
  checkFavoriteExists() async {
    var user = Provider.of<User?>(context);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(widget.article.id)
        .snapshots().listen((value) {
         bool state = value.get('favorite');
          if (state == true) {
      setState(() {
        _isFavorite = true;
      });
    } else {}
        });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var user = Provider.of<User?>(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
       children: [
         Container(
           padding: EdgeInsets.all(defaultSize! * 2),
           decoration: BoxDecoration(
             color: theme.cardColor,
             boxShadow: [
               BoxShadow(
                 color: kShadowColor,
               ),
             ],
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Expanded(
                 child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Text(
                 "Select Option",
                 style: TextStyle(
                   fontSize: defaultSize! * 2.2,
                   fontWeight: FontWeight.w900,
                   fontFamily: 'Larken',
                   decoration: TextDecoration.none,
                 ),
               ),
               SizedBox(
                 height: 5.0,
               ),
               Text(
                 "choose an option",
                 style: TextStyle(
                   fontSize: defaultSize! * 1.6,
                   fontFamily: 'Larken',
                   decoration: TextDecoration.none,
                 ),
               ),
             ],
           ),
               ),
           GestureDetector(
             child: Icon(Icons.close),
             onTap: widget.onClose,
           ),
             ],
           ),
         ),
         _buildTile(
           title: 'Share the Post',
           onTap: () {
             _functions.sharePost(
               url: widget.article.get('linkURL'),
             );
           },
         ),
         _buildTile(
           title: 'Go to Source URL',
           onTap: () {
             _functions.launchSourceUrl(
               widget.article.get('linkURL'),
             );
           },
         ),
         _buildTile(
           title: _isFavorite ? 'Added to Favorites' : 'Add to Favorites',
           onTap: () {
             _showInterstitialAd();
             setState(() {
               if (_isFavorite != true) {
                 _isFavorite = true;
                 _db.addtoFavorites(data: widget.article, user: user);
               } else {
                 _db.removeFromFavorites(docID: widget.article.id, user: user);
               }
             });
           },
         ),
         _buildTile(
           title: _isSaved ? 'Added to Saved' : 'Add to Saved',
           onTap: () {
             _showInterstitialAd();
             setState(() {
               if (_isSaved != true) {
                 _isSaved = true;
                 _db.addtoSaved(data: widget.article, user: user);
               } else {
                 _db.removeFromSaved(docID: widget.article.id, user: user);
               }
             });
           },
         ),
         _buildTile(
           title: 'Report Content',
           onTap: () {
             _functions.sendReport();
           },
         ),
         SizedBox(height: defaultSize! * 1),
       ],
      ),
    );
  }

  ListTile _buildTile({String? title, VoidCallback? onTap}) {
    var theme = Theme.of(context);
    double? defaultSize = SizeConfig.defaultSize;
    return ListTile(
      title: Text(
        title!,
        style: TextStyle(
          fontFamily: 'Larken',
          fontSize: defaultSize! * 1.8,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: SvgPicture.asset('assets/icons/chevron_right.svg', color: theme.iconTheme.color),
      onTap: onTap,
    );
  }
}
