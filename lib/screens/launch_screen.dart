import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final PushNotifyManager _notifyManager = PushNotifyManager();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    double? defaultSize = SizeConfig.defaultSize;
    var _auth = Provider.of<AuthServices>(context);

    return _isLoading
        ? Loader()
        : Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(defaultSize! * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    Container(
                      height: defaultSize * 12,
                      width: defaultSize * 12,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: defaultSize * 1.5),
                    Text(
                      'Your Daily News Updates',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kFontColor,
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 4.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: defaultSize * 0.8),
                    Text(
                      'Reaching Out to you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Larken',
                        fontSize: defaultSize * 1.8,
                      ),
                    ),
                    SizedBox(height: defaultSize * 10),
                    RegularButton(
                      title: 'Sign Up with Email ID',
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                    SizedBox(height: defaultSize * 1),
                    BorderButton(
                      title: 'Sign Up with Google',
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await _auth.signInWithGoogle();
                        _notifyManager.createUserData(user: user!);
                        _notifyManager.subscribe();
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pushNamed(context, "/base");
                      },
                    ),
                    SizedBox(height: defaultSize * 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           'Already have an Account? ',
                           style: TextStyle(
                            color: kFontColor,
                            fontFamily: 'Larken',
                            fontSize: defaultSize * 1.5,
                            fontWeight: FontWeight.w500,
                           ),
                          ),
                          GestureDetector(
                            onTap: () {
                             Navigator.pushNamed(context, "/login");
                            },
                            child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: kFontColor,
                              fontFamily: 'Larken',
                              decoration: TextDecoration.underline,
                              fontSize: defaultSize * 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}
