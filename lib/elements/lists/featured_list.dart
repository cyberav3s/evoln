import 'package:animate_do/animate_do.dart';
import 'package:evoln/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/elements/cards/article_card.dart';
import 'package:evoln/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:evoln/widgets/loader.dart';
import 'package:evoln/widgets/time_ago.dart';
import 'package:flutter/material.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({Key? key}) : super(key: key);

  static Stream<QuerySnapshot> _articlesStream() {
    return FirebaseFirestore.instance
        .collection('Featured')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    final DatabaseService _db = DatabaseService();
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      height: defaultSize! * 34,
      child: StreamBuilder(
        stream: _articlesStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> articles) {
          if (articles.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          if (articles.hasError) {
            return Center(
              child: Text('Something went wrong...'),
            );
          }
          if (articles.hasData) {
            if (articles.data != null) {
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: defaultSize * 2),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.5),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var data = articles.data!.docs[index];
                  return SlideInRight(
                    child: ArticleCard(
                      title: data['newsHeadline'],
                      posted: TimeAgo.timeAgoSinceDate(data['newsUploadTime']),
                      category: data['category'],
                      thumbnail: data['thumbnail'],
                      onTap: () {
                        _db.addtoHistory(user: user!, data: articles.data!.docs[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              article: articles.data!.docs[index],
                            ),
                          ),
                        );
                      },
                      article: articles.data!.docs[index],
                      docId: data['docName'],
                      source: data['linkURL'],
                    ),
                  );
                },
              );
            } else {
              return ErrorWidget.withDetails(
                message: 'Something went wrong...',
                error: FlutterError(
                  'Seems like application may be failed to get articles from database. please restart application.',
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
