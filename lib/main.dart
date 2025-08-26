import 'package:evoln/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:evoln/libraries/lib.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(CoreApp());
}

class CoreApp extends StatefulWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  _CoreAppState createState() => _CoreAppState();
}

class _CoreAppState extends State<CoreApp> {
  final DatabaseService db = DatabaseService();
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        StreamProvider<User?>(
          initialData: FirebaseAuth.instance.currentUser,
          create: (context) => context.read<AuthServices>().authChanges,
        ),
      ],
      child: MediaQuery(
        data: MediaQueryData(),
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, theme, Widget? child) {
            return MaterialApp(
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
              ],
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: generateRoutes,
            );
          },
        ),
      ),
    );
  }
}

class AuthListener extends StatelessWidget {
  const AuthListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PushNotifyManager.initialize(context);
    SizeConfig().init(context);
    var user = context.watch<User?>();
    if (user == null) {
      return LaunchScreen();
    }
    return Base();
  }
}
