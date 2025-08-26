import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.initialAnimation}) : super(key: key);

  final Animation<double> initialAnimation;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Functions _functions = Functions();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                    'Sign in',
                    style: TextStyle(
                      color: kFontColor,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 4.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome back, continue to sign in into your account.',
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/forget");
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: kFontColor,
                          letterSpacing: 0.5,
                          fontFamily: 'Larken',
                          fontSize: defaultSize * 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: defaultSize * 5),
                  RegularButton(
                    title: 'Sign in',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        bool signed = await _auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (signed) {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/base', (route) => false);
                        } else {
                          print('Failed to sign in user');
                        }
                      }
                    },
                  ),
                  SizedBox(height: defaultSize * 1),
                  BorderButton(
                    title: 'Sign in with Google',
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await _auth.signInWithGoogle();
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/base', (route) => false);
                    },
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have an Account? ",
                        style: TextStyle(
                          color: kFontColor,
                          fontFamily: 'Larken',
                          fontSize: defaultSize * 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: Text(
                          'Sign up',
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
          );
  }
}
