import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/services/db.dart';
import 'package:evoln/services/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({
    Key? key,
    required this.title,
    required this.posted,
    required this.category,
    required this.thumbnail,
    this.onTap,
    required this.docId,
    required this.source,
    required this.article,
  }) : super(key: key);

  final String title;
  final String thumbnail;
  final String posted;
  final String docId;
  final String source;
  final QueryDocumentSnapshot article;
  final String category;
  final VoidCallback? onTap;

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  final DatabaseService _db = DatabaseService();
  final Functions _functions = Functions();
  bool _isFavorite = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      checkExists();
    });
    super.initState();
  }

  checkExists() async {
    var user = Provider.of<User?>(context, listen: false);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(widget.docId)
        .snapshots()
        .listen((value) {
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
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      height: defaultSize! * 35,
      width: defaultSize * 19,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                height: defaultSize * 25.5,
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(
                    right: defaultSize * 0.8, top: defaultSize * 0.8),
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  height: defaultSize * 4,
                  width: defaultSize * 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      _isFavorite
                          ? 'assets/icons/favorite_fill.svg'
                          : 'assets/icons/favorite.svg',
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_isFavorite == true) {
                          _isFavorite = false;
                          _db.removeFromFavorites(
                            docID: widget.docId,
                            user: user,
                          );
                        } else {
                          _isFavorite = true;
                          _db.addtoFavorites(
                            data: widget.article,
                            user: user,
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _functions.launchSourceUrl(widget.source);
                    },
                    child: Text(
                      "Source",
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: defaultSize * 0.4),
                  Text(
                    "${widget.title}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 1.5,
                    ),
                  ),
                  SizedBox(height: defaultSize * 0.4),
                  Text(
                    "${widget.category}  |  ${widget.posted}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
