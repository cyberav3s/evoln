import 'package:flutter/material.dart';
import 'package:evoln/libraries/screens.dart';

class ForgetScreen extends StatefulWidget {
  ForgetScreen({Key? key, required this.initialAnimation}) : super(key: key);

  final Animation<double> initialAnimation;

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
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
                  fontSize: defaultSize! * 2.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                IconButton(
                  icon: SvgPicture.asset('assets/icons/into.svg'),
                  onPressed: () {},
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(defaultSize * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(
                      color: kFontColor,
                      fontFamily: 'Larken',
                      fontSize: defaultSize * 4.4,
                  fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Seems like you have forget your password, don't worry we will help you out.",
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
                          trailing: IconButton(
                            icon: SvgPicture.asset('assets/icons/send.svg'),
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              _auth.sendResetPassword(_emailController.text);
                              setState(() {
                                _isLoading = false;
                              });
                            },
                          ),
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
                          hint: 'New Password',
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
                                ? 'New Password is required'
                                : null;
                          },
                        ),
                        SizedBox(height: defaultSize * 2),
                      ],
                    ),
                  ),
                  SizedBox(height: defaultSize * 5),
                  RegularButton(
                    title: 'Submit',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        bool signed = await _auth.confirmResetPassword(
                          email: _emailController.text,
                          code: _codeController.text,
                          newPassword: _passwordController.text,
                        );
                        if (signed) {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pushNamed(context, "/login");
                        } else {
                          print('Failed to sign in user');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
