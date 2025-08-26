import 'package:evoln/libraries/screens.dart';
import 'package:flutter/material.dart';
import 'package:evoln/libraries/lib.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  double? defaultSize = SizeConfig.defaultSize;
  int _selectedIndex = 0;

  List<Widget> _widgetOption = [
    HomeScreen(),
    ExploreScreen(),
    LibraryScreen(),
  ];

  @override
  void initState() {
    checkConnection();
    _fcm.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title!);
        print(message.notification!.body!);
        notifications.add(
          PushNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            imageUrl: message.notification!.android!.imageUrl!,
          ),
        );
        PushNotifyManager.display(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final route = message.data['route'];
      print(message.notification!.title!);
      print(message.notification!.body!);
      notifications.add(
        PushNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          imageUrl: message.notification!.android!.imageUrl!,
        ),
      );
      Navigator.of(context, rootNavigator: route);
    });
    super.initState();
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> checkConnection() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      print("You're Connected to the Internet.");
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "You're Not Connected to Internet.",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF282828),
        selectedItemColor: Colors.greenAccent[400],
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          color: Colors.greenAccent[400],
          fontFamily: 'Larken',
          fontSize: defaultSize! * 1.4,
          fontWeight: FontWeight.w100,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Larken',
          fontSize: defaultSize! * 1.4,
          fontWeight: FontWeight.w400,
        ),
        enableFeedback: true,
        currentIndex: _selectedIndex,
        onTap: _handleIndexChanged,
        items: [
          BottomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                _selectedIndex == 0
                    ? 'assets/icons/home_fill.svg'
                    : 'assets/icons/home.svg',
                color: _selectedIndex == 0 ? Color(0xFF20EE8A) : Colors.grey,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                color: _selectedIndex == 1 ? Color(0xFF20EE8A) : Colors.grey,
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                _selectedIndex == 2
                    ? 'assets/icons/library_fill.svg'
                    : 'assets/icons/library.svg',
                height: 20.0,
                width: 20.0,
                color: _selectedIndex == 2 ? Color(0xFF20EE8A) : Colors.grey,
              ),
            ),
            label: 'Your Library',
          ),
        ],
      ),
      body: _widgetOption.elementAt(_selectedIndex),
    );
  }
}
