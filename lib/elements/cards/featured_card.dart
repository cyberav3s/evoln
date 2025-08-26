import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:evoln/screens/details_screen.dart';
import 'package:evoln/widgets/loader.dart';
import 'package:evoln/widgets/time_ago.dart';
import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  FeaturedCard({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _articleStream() {
      return FirebaseFirestore.instance.collection('Stories').snapshots();
    }

    var theme = Theme.of(context);
    double? defaultSize = SizeConfig.defaultSize;
    return StreamBuilder(
      stream: _articleStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> article) {
        if (article.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        if (article.hasError) {
            return Center(
              child: Text('Something went wrong...'),
            );
        }
        if (article.hasData) {
          if (article.data != null) {
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              children: article.data!.docs.map(
                (data) {
                  return Container(
                    height: SizeConfig.defaultSize! * 27,
                    width: SizeConfig.screenWidth,
                    color: theme.backgroundColor,
                    margin: EdgeInsets.symmetric(horizontal: defaultSize! * 1.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  article: data,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: SizeConfig.defaultSize! * 20,
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                              color: Color(0xFF262626),
                              borderRadius: BorderRadius.circular(6.0),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(data['thumbnail']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: defaultSize * 0.8,
                              bottom: defaultSize * 0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                data['newsHeadline'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Larken',
                                  fontSize: SizeConfig.defaultSize! * 1.7,
                                ),
                              ),
                              SizedBox(height: defaultSize * 0.3),
                              Text(
                                "${data['category']}  |  ${TimeAgo.timeAgoSinceDate(data['newsUploadTime'])}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Larken',
                                  fontSize: SizeConfig.defaultSize! * 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          }
        }
        return Loader();
      },
    );
  }
}
