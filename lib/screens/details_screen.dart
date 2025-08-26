import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.article}) : super(key: key);

  final QueryDocumentSnapshot article;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  PanelController _panelController = PanelController();
  double? defaultSize = SizeConfig.defaultSize;
  double _value = 1.9;

  @override
  void initState() {
    _panelController = PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        minHeight: 0,
        boxShadow: [
          BoxShadow(color: kShadowColor),
        ],
        maxHeight: defaultSize! * 39,
        controller: _panelController,
        color: theme.cardColor,
        panel: DetailsPanel(
          article: widget.article,
          onClose: () {
            _panelController.close();
          },
        ),
        body: Container(
          color: theme.backgroundColor,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              _buildSliverBody(),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    var theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: 5.0,
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Details',
        style: TextStyle(
          fontFamily: 'Larken',
          fontSize: defaultSize! * 2.2,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: theme.appBarTheme.iconTheme!.color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/typography.svg',
            color: theme.appBarTheme.iconTheme!.color,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: defaultSize! * 15,
                  width: SizeConfig.screenWidth,
                  color: theme.backgroundColor,
                  child: Padding(
                    padding: EdgeInsets.all(defaultSize! * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Typography',
                          style: TextStyle(
                            fontFamily: 'Larken',
                            fontSize: defaultSize! * 1.8,
                          ),
                        ),
                        SizedBox(height: defaultSize! * 1.7),
                        Container(
                          height: defaultSize! * 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: theme.cardColor,
                          ),
                          child: Slider(
                            value: _value,
                            min: 0.0,
                            max: 5.0,
                            onChanged: (double s) {
                              setState(() {
                                _value = s;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/more_horiz.svg',
            color: theme.appBarTheme.iconTheme!.color,
          ),
          onPressed: () {
            _panelController.open();
          },
        ),
      ],
    );
  }

  SelectableText _buildText({required String title}) {
    return SelectableText(
      title,
      style: TextStyle(
        fontFamily: 'Larken',
        fontSize: defaultSize! * _value,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w100,
      ),
    );
  }

  Widget _buildSliverBody() => SliverFillRemaining(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: defaultSize! * 2,
                left: defaultSize! * 2,
                right: defaultSize! * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultSize! * 1),
                    child: SelectableText(
                      widget.article.get('newsHeadline'),
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize! * 3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    'Posted on •  ${widget.article.get('newsUploadTime')}',
                    style: TextStyle(
                      fontFamily: 'Larken',
                      fontSize: defaultSize! * 1.5,
                    ),
                  ),
                  SizedBox(height: defaultSize! * 1),
                  Container(
                    height: SizeConfig.defaultSize! * 20,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFF262626),
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            widget.article.get('thumbnail')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultSize! * 1),
                    child: SelectableText(
                      widget.article.get('headline Category'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Larken',
                        fontSize: defaultSize! * 1.8,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildText(title: widget.article.get('newsBody 1')),
                      SizedBox(height: defaultSize! * 2),
                      _buildText(title: widget.article.get('newsBody 2')),
                      SizedBox(height: defaultSize! * 2),
                      _buildText(title: widget.article.get('newsBody 3')),
                      if (widget.article.get('bodyImage 1') != '')
                        Padding(
                          padding: EdgeInsets.only(
                            top: defaultSize! * 2,
                            bottom: defaultSize! * 2,
                          ),
                          child: Image.network(
                            widget.article.get('bodyImage 1'),
                          ),
                        )
                      else
                        SizedBox(height: defaultSize! * 2),
                      _buildText(title: widget.article.get('newsBody 4')),
                      SizedBox(height: defaultSize! * 2),
                      _buildText(title: widget.article.get('newsBody 5')),
                      if (widget.article.get('bodyImage 2') != '')
                        Padding(
                          padding: EdgeInsets.only(
                            top: defaultSize! * 2,
                            bottom: defaultSize! * 2,
                          ),
                          child: Image.network(
                            widget.article.get('bodyImage 2'),
                          ),
                        )
                      else
                        SizedBox(height: defaultSize! * 2),
                      _buildText(title: widget.article.get('newsBody 6')),
                    ],
                  ),
                  SizedBox(height: defaultSize! * 2),
                ],
              ),
            ),
          ),
        ),
      );
}
