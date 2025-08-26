import 'dart:io';
import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

extension on Availability {
  String stringify() => this.toString().split('.').last;
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, required this.initialAnimation}) : super(key: key);

  final Animation<double> initialAnimation;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final InAppReview _inAppReview = InAppReview.instance;
  final PushNotifyManager _notifyManager = PushNotifyManager();
  final Functions _functions = Functions();
  DarkThemePreference preference = DarkThemePreference();
  double? defaultSize = SizeConfig.defaultSize;
  bool _isSubscribed = true;
  bool isDarkMode = false;

  String _appStoreId = 'com.cyberav3s.evoln';
  Availability _availability = Availability.LOADING;

  Future<void> getStatus() async {
    bool mode = await preference.getTheme();
    if (mode == true) {
      setState(() {
        isDarkMode = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStatus();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.AVAILABLE
              : Availability.UNAVAILABLE;
        });
      } catch (e) {
        setState(() => _availability = Availability.UNAVAILABLE);
      }
    });
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
      );

  @override
  Widget build(BuildContext context) {
    var themeChange = Provider.of<DarkThemeProvider>(context);
    double? defaultSize = SizeConfig.defaultSize;
    var user = Provider.of<User?>(context);
    var theme = Theme.of(context);
    var _auth = Provider.of<AuthServices>(context);
    if (user == null) {
      user!.reload();
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20.0,
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
          'Settings',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildOption('Account'),
                  buildListTile(
                    title: user.displayName ?? user.uid,
                    subtitle: Text(
                      '${user.email}',
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.4,
                      ),
                    ),
                    onTap: () {},
                  ),
                  buildListTile(
                    title: 'Log out',
                    onTap: () async {
                       await _auth.signOut();
                       Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                    },
                  ),
                  Divider(),
                  buildOption('General'),
                  buildListTile(
                    title: 'Dark Mode',
                    trailing: Checkbox(
                      value: isDarkMode,
                      onChanged: (bool? value) {
                        setState(() {
                          themeChange.darkTheme = value!;
                          isDarkMode = !isDarkMode;
                        });
                      },
                    ),
                  ),
                  buildListTile(
                    title: 'Language',
                    subtitle: Text(
                      'English',
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.4,
                      ),
                    ),
                    onTap: () {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message:
                              "This feature is currently in development and will be available in future update.",
                        ),
                      );
                    },
                  ),
                  Divider(),
                  buildOption('Notifications'),
                  buildListTile(
                    title: 'Push notifications',
                    trailing: Checkbox(
                      value: _isSubscribed,
                      onChanged: (bool? value) {
                        setState(() {
                          if (_isSubscribed != true) {
                            _isSubscribed = true;
                            _notifyManager.subscribe();
                          } else {
                            _isSubscribed = false;
                            _notifyManager.unsubscribe();
                          }
                        });
                      },
                    ),
                  ),
                  Divider(),
                  buildOption('About'),
                  buildListTile(
                    title: 'Privacy policy',
                    trailing: null,
                    onTap: () {
                      _functions.privacyPolicy();
                    },
                  ),
                  buildListTile(
                    title: 'Terms & conditions',
                    trailing: null,
                    onTap: () {
                      _functions.termsOfUses();
                    },
                  ),
                  buildListTile(
                    title: 'Feedback',
                    subtitle: Text(
                      'InAppReview status: ${_availability.stringify()}',
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.4,
                      ),
                    ),
                    onTap: _requestReview,
                  ),
                  buildListTile(
                    title: 'Rate Evoln',
                    subtitle: Text(
                      "Enjoying the app ? tell us all about it on Google Play",
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.4,
                      ),
                    ),
                    onTap: _openStoreListing,
                  ),
                  buildListTile(
                    title: 'Share Evoln',
                    subtitle: Text(
                      'Share your thoughts about this app with your friends.',
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.4,
                      ),
                    ),
                    onTap: () {
                      _functions.shareApp();
                    },
                  ),
                  buildListTile(
                    title: 'Follow on Instagram',
                    trailing: null,
                    onTap: () {
                      _functions.followOnInstagram();
                    },
                  ),
                  buildListTile(
                    title: 'Follow on Youtube',
                    trailing: null,
                    onTap: () {
                      _functions.followOnYoutube();
                    },
                  ),
                  buildListTile(
                    title: 'Follow on Twitter',
                    trailing: null,
                    onTap: () {
                      _functions.followOnTwitter();
                    },
                  ),
                  Divider(),
                  buildOption('Miscellaneous'),
                  buildListTile(
                    title: 'Version',
                    subtitle: Text(
                      '1.3.9510 (139510), production',
                      style: TextStyle(
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.4,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption(String optionTitle) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: defaultSize! * 0.5,
        left: defaultSize! * 1.5,
        top: defaultSize! * 0.5,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          optionTitle,
          style: TextStyle(
            fontFamily: 'Larken',
            fontSize: defaultSize! * 1.4,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget buildListTile(
      {String? title, Text? subtitle, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title!,
        style: TextStyle(
          fontFamily: 'Larken',
          fontSize: defaultSize! * 1.5,
        ),
      ),
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
