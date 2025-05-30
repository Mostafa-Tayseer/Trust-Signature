import 'package:flutter/material.dart';
import 'package:project_youssef/signup_page.dart';
import 'package:project_youssef/upload_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project_youssef/common/page_header.dart';
import 'package:project_youssef/common/page_heading.dart';
import 'package:project_youssef/forget-password-page.dart';
import 'package:project_youssef/common/custom_form_button.dart';
import 'package:project_youssef/common/custom_input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:login_signup/components/signup_page.dart';
// import 'package:login_signup/components/common/page_header.dart';
// import 'package:login_signup/components/common/page_heading.dart';
// import 'package:login_signup/components/forget_password_page.dart';
// import 'package:login_signup/components/signup_page.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:login_signup/components/common/page_heading.dart';
// import 'package:login_signup/components/common/custom_form_button.dart';
// import 'package:login_signup/components/common/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> signIn() async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response.user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UploadPage()));
        print("Login successful: ${response.user?.email}");
        return true;
      } else {
        print("Login failed: No user returned.");
        return false;
      }
    } catch (error) {
      print("Login failed: $error");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(
                          title: 'Log-in',
                        ),
                        CustomInputField(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: 'Your email id',
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if (!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordPage()))
                            },
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomFormButton(
                          innerText: 'Login',
                          onPressed: _handleLoginUser,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ? ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff939393),
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage()))
                                },
                                child: const Text(
                                  'Sign-up',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff748288),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginUser() {
    if (_loginFormKey.currentState!.validate()) {
      signIn();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const UploadPage()));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Submitting data..')),
      // );
    }
  }
}
