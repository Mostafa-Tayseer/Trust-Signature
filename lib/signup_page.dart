import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_youssef/common/custom_form_button.dart';
import 'package:project_youssef/common/custom_input_field.dart';
import 'package:project_youssef/common/page_heading.dart';
import 'package:project_youssef/login_page.dart';
import 'package:project_youssef/upload_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final Color Color(0xffEEF1F3);


  final _signupFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

Future<bool> signUp() async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response.user != null) {
        print("Signup successful: ${response.user?.email}");
        return true;
      } else {
        print("Signup failed: No user returned.");
        return false;
      }
    } catch (error) {
      print("Signup failed: $error");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        appBar: AppBar(
          backgroundColor: const Color(0xffEEF1F3),
          title: const Text("Sign-up"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const PageHeading(title: 'Sign-up'),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: _nameController,
                        labelText: 'Name',
                        hintText: 'Your name',
                        isDense: true,
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Name field is required!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Your email id',
                        isDense: true,
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Email is required!';
                          }
                          if (!EmailValidator.validate(textValue)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: _contactController,
                        labelText: 'Contact no.',
                        hintText: 'Your contact number',
                        isDense: true,
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Contact number is required!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: 'Your password',
                        isDense: true,
                        obscureText: true,
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Password is required!';
                          }
                          return null;
                        },
                        suffixIcon: true,
                      ),
                      const SizedBox(height: 22),
                      CustomFormButton(
                        innerText: 'Signup',
                        onPressed: _handleSignupUser,
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ? ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff939393),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Log-in',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff748288),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignupUser() async {
    if (_signupFormKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final contact = _contactController.text;
      final password = _passwordController.text;

      print('Name: $name');
      print('Email: $email');
      print('Contact: $contact');
      print('Password: $password');

      final success = await signUp();

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful!')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UploadPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup failed. Please try again.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
