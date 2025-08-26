import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/elements/cards/recommend_card.dart';
import 'package:evoln/screens/details_screen.dart';
import 'package:evoln/widgets/loader.dart';
import 'package:evoln/widgets/time_ago.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    var theme = Theme.of(context);
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: theme.iconTheme.color,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    var theme = Theme.of(context);
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: theme.iconTheme.color,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    final Stream<QuerySnapshot> _articlesStream = FirebaseFirestore.instance
        .collection('Recommended')
        .where('searchKey', isEqualTo: query)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return StreamBuilder(
      stream: _articlesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('Not found articles from $query'),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: defaultSize! * 1,
                left: defaultSize * 1,
                right: defaultSize * 1),
            itemCount: snapshot.data!.docs.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return RecommendCard(
                title: data['newsHeadline'],
                posted: TimeAgo.timeAgoSinceDate(data['newsUploadTime']),
                category: data['category'],
                thumbnail: data['thumbnail'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        article: snapshot.data!.docs[index],
                      ),
                    ),
                  );
                },
                article: snapshot.data!.docs[index],
                docId: data['docName'],
                source: data['linkURL'],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            query,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          leading: Icon(
            Icons.access_time,
            color: theme.iconTheme.color,
          ),
        );
      },
    );
  }
}
