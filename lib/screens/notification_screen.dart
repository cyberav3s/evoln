import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.initialAnimation})
      : super(key: key);

  final Animation<double> initialAnimation;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  double? defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: theme.backgroundColor,
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/close.svg',
                    height: defaultSize! * 4,
                    width: defaultSize! * 4,
                    color: theme.appBarTheme.iconTheme!.color,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              pinned: true,
              title: 'Notifications',
            ),
            _buildSliverBody(),
          ],
        ),
      ),
    );
  }

  SliverList _buildSliverBody() {
    var theme = Theme.of(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        Scrollbar(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            children: notifications.map((e) {
              return SlideInUp(
                child: Container(
                  height: defaultSize! * 13,
                  width: SizeConfig.screenWidth,
                  color: theme.backgroundColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultSize! * 2, vertical: defaultSize! * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Nexa',
                                fontSize: defaultSize! * 1.3,
                              ),
                            ),
                            Text(
                              "${e.body}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Nexa',
                                fontSize: defaultSize! * 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: defaultSize! * 1),
                      Container(
                        height: defaultSize! * 10,
                        width: defaultSize! * 10,
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(e.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
