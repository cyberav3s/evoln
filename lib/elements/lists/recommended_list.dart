import 'package:animate_do/animate_do.dart';
import 'package:evoln/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evoln/elements/cards/recommend_card.dart';
import 'package:evoln/screens/details_screen.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:evoln/widgets/time_ago.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({Key? key}) : super(key: key);

  static Stream<QuerySnapshot> _articlesStream() {
    return FirebaseFirestore.instance
        .collection('Recommended')
        .orderBy('timestamp', descending: true)
        .limit(30)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    final DatabaseService _db = DatabaseService();
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
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
                separatorBuilder: (context, index) => SizedBox(height: defaultSize! * 2),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: articles.data!.docs.length,
                padding: EdgeInsets.symmetric(horizontal: defaultSize! * 1.5),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var data = articles.data!.docs[index];
                  return SlideInUp(
                    child: RecommendCard(
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
            }
          }
          return Loader();
        },
      ),
    );
  }
}
