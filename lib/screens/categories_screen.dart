import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Stream<QuerySnapshot> _articlesStream = FirebaseFirestore.instance
        .collection('Recommended')
        .where('searchKey', isEqualTo: title)
        .orderBy('timestamp', descending: true)
        .snapshots();
    double? defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            color: theme.appBarTheme.iconTheme!.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Larken',
            fontSize: defaultSize! * 2.2,
            wordSpacing: 0.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Scrollbar(
            child: StreamBuilder(
              stream: _articlesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> articles) {
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
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultSize * 1.5,
                          vertical: defaultSize * 1),
                      itemCount: articles.data!.docs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var data = articles.data!.docs[index];
                        return RecommendCard(
                          title: data['newsHeadline'],
                          posted: TimeAgo.timeAgoSinceDate(
                            data['newsUploadTime'],
                          ),
                          category: data['category'],
                          thumbnail: data['thumbnail'],
                          onTap: () {
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
                return Loader();
              },
            ),
          ),
        ),
      ),
    );
  }
}
