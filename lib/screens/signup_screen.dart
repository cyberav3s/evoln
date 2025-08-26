import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.initialAnimation}) : super(key: key);

  final Animation<double> initialAnimation;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Functions _functions = Functions();
  final PushNotifyManager _notifyManager = PushNotifyManager();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var _auth = Provider.of<AuthServices>(context);
    double? defaultSize = SizeConfig.defaultSize;
    return _isLoading
        ? Loader()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
              backgroundColor: Color(0xFFFFFFFF),
              leading: IconButton(
                icon: SvgPicture.asset('assets/icons/back.svg'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
              title: Text(
                'Back',
                style: TextStyle(
                  color: kFontColor,
                  fontFamily: 'Larken',
                  fontSize: defaultSize! * 2.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                IconButton(
                  icon: SvgPicture.asset('assets/icons/into.svg'),
                  onPressed: () {
                      _functions.privacyPolicy();
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(defaultSize * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: kFontColor,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 4.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Create an account so you can save your favorite content forever.',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 0.5,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 1.9,
                    ),
                  ),
                  SizedBox(height: defaultSize * 5),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthFormField(
                          hint: 'Email',
                          leading: 'assets/icons/mail.svg',
                          trailing: null,
                          obscureText: false,
                          controller: _emailController,
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? 'E-mail address is required'
                                : null;
                          },
                        ),
                        SizedBox(height: defaultSize * 2),
                        AuthFormField(
                          hint: 'Password',
                          leading: 'assets/icons/lock.svg',
                          trailing: IconButton(
                            icon: SvgPicture.asset(
                              _obscureText
                                  ? 'assets/icons/show.svg'
                                  : 'assets/icons/hide.svg',
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          obscureText: _obscureText ? true : false,
                          controller: _passwordController,
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? 'Password is required'
                                : null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: defaultSize * 1),
                  Text(
                    "Your password must be 8 or more charactars long & contain a mix of upper & lower case letters, numbers, & symbols.",
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 0.5,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 1.4,
                    ),
                  ),
                  SizedBox(height: defaultSize * 5),
                  RegularButton(
                    title: 'Create an Account',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        bool signed = await _auth.signUpWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (signed) {
                          setState(() {
                            _isLoading = false;
                          });
                        _notifyManager.createUserData(user: user!);
                        _notifyManager.subscribe();
                          Navigator.pushNamed(context, "/base");
                        } else {
                          print('Failed to sign up user');
                        }
                      }
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: defaultSize * 6, right: defaultSize * 6),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Larken',
                          fontSize: defaultSize * 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: "By signing up, you're agree to our ",
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(
                              color: kFontColor,
                              fontFamily: 'Larken',
                              fontSize: defaultSize * 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              color: kFontColor,
                              fontFamily: 'Larken',
                              fontSize: defaultSize * 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
