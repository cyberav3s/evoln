import 'package:cached_network_image/cached_network_image.dart';
import 'package:evoln/config/size/size_config.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.title,
    required this.posted,
    required this.category,
    required this.thumbnail,
    this.onTap,
    required this.docId,
    required this.source,
  }) : super(key: key);

  final String title;
  final String thumbnail;
  final String posted;
  final String docId;
  final String source;
  final String category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double? defaultSize = SizeConfig.defaultSize;
    return Container(
      height: defaultSize! * 12.5,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(
        left: defaultSize * 1.5,
        right: defaultSize * 1,
      ),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: defaultSize * 12,
              width: defaultSize * 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: defaultSize * 1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "$category  |  $posted",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 1.3,
                    ),
                  ),
                  Text(
                    "$title",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 1.7,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
