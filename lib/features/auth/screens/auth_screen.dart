import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/custom_button.dart';
import 'package:flutter_amazon/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/features/auth/services/auth_service.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      // appBar: AppBar(title: const Text("Welcome", style: TextStyle(fontSize: 24),)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Container(
                margin: EdgeInsets.only(bottom: _auth == Auth.signup ? 0 : 8),
                decoration: BoxDecoration(
                  color:
                      _auth == Auth.signup
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    bottomLeft: Radius.circular(_auth == Auth.signup ? 0 : 8),
                    bottomRight: Radius.circular(_auth == Auth.signup ? 0 : 8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      title: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              _auth == Auth.signup
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                          color:
                              _auth == Auth.signup
                                  ? GlobalVariables.secondaryColor
                                  : Colors.black87,
                        ),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signup,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                    if (_auth == Auth.signup)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: GlobalVariables.backgroundColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          border: Border(
                            top: BorderSide(
                              color: GlobalVariables.secondaryColor.withOpacity(
                                0.3,
                              ),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Form(
                          key: _signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextfield(
                                controller: _nameController,
                                hintText: "Name",
                              ),
                              const SizedBox(height: 14),
                              CustomTextfield(
                                controller: _emailController,
                                hintText: "Email",
                              ),
                              const SizedBox(height: 14),
                              CustomTextfield(
                                controller: _passwordController,
                                hintText: "Password",
                              ),
                              const SizedBox(height: 20),
                              CustomButton(text: "Sign-Up", onTap: () {
                                if(_signUpFormKey.currentState!.validate()){
                                  signUpUser();
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: _auth == Auth.signin ? 0 : 8),
                decoration: BoxDecoration(
                  color:
                      _auth == Auth.signin
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    bottomLeft: Radius.circular(_auth == Auth.signin ? 0 : 8),
                    bottomRight: Radius.circular(_auth == Auth.signin ? 0 : 8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      title: Text(
                        "Sign-in",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              _auth == Auth.signin
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                          color:
                              _auth == Auth.signin
                                  ? GlobalVariables.secondaryColor
                                  : Colors.black87,
                        ),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signin,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                    if (_auth == Auth.signin)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: GlobalVariables.backgroundColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          border: Border(
                            top: BorderSide(
                              color: GlobalVariables.secondaryColor.withOpacity(
                                0.3,
                              ),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Form(
                          key: _signInFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextfield(
                                controller: _emailController,
                                hintText: "Email",
                              ),
                              const SizedBox(height: 14),
                              CustomTextfield(
                                controller: _passwordController,
                                hintText: "Password",
                              ),
                              const SizedBox(height: 20),
                              CustomButton(text: "Sign-In", onTap: () {}),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
